//
//  AsynImage+Extension.swift
//  MealsApp
//
//  Created by Isaac Dimas on 01/10/23.
//

import SwiftUI
import Combine
import Photos

struct ImageView<Placeholder>: View where Placeholder: View {

    // MARK: - Value
    // MARK: Private
    @State private var image: Image? = nil
    @State private var task: Task<(), Never>? = nil
    @State private var isProgressing = false

    private let url: URL?
    private let placeholder: () -> Placeholder?


    // MARK: - Initializer
    init(url: URL?, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder
    }

    init(url: URL?) where Placeholder == Color {
        self.init(url: url, placeholder: { Color("neutral9") })
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                placholderView
                imageView
                progressView
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .task {
                task?.cancel()
                task = Task.detached(priority: .background) {
                    await MainActor.run { isProgressing = true }
                
                    do {
                        let image = try await ImageManager.shared.download(url: url)
                    
                        await MainActor.run {
                            isProgressing = false
                            self.image = image
                        }
                    
                    } catch {
                        await MainActor.run { isProgressing = false }
                    }
                }
            }
            .onDisappear {
                task?.cancel()
            }
        }
    }
    
    // MARK: Private
    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFill()
        }
    }

    @ViewBuilder
    private var placholderView: some View {
        if !isProgressing, image == nil {
            placeholder()
        }
    }
    
    @ViewBuilder
    private var progressView: some View {
        if isProgressing {
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
}


#if DEBUG
struct ImageView_Previews: PreviewProvider {

    static var previews: some View {
        let view = VStack {
            ImageView(url: URL(string: "https://wallpaperset.com/w/full/d/2/b/115638.jpg"))
                .frame(width: 300, height: 300)
                .cornerRadius(20)
        
            ImageView(url: URL(string: "https://wallpaperset.com/w/full/d/2/b/115638")) {
                Text("⚠️")
                    .font(.system(size: 120))
            }
            .frame(width: 300, height: 300)
            .cornerRadius(20)
        }
    
        view
            .previewDevice("iPhone 11 Pro")
            .preferredColorScheme(.light)
    }
}
#endif



final class ImageManager {
    
    // MARK: - Singleton
    static let shared = ImageManager()
    
    
    // MARK: - Value
    // MARK: Private
    private lazy var imageCache = NSCache<NSString, UIImage>()
    private var loadTasks = [PHAsset: PHImageRequestID]()
    
    private let queue = DispatchQueue(label: "ImageDataManagerQueue")
    
    private lazy var imageManager: PHCachingImageManager = {
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        return imageManager
    }()

    private lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 90
        configuration.timeoutIntervalForRequest     = 90
        configuration.timeoutIntervalForResource    = 90
        return URLSession(configuration: configuration)
    }()
    
    
    // MARK: - Initializer
    private init() {}
    
    
    // MARK: - Function
    // MARK: Public
    func download(url: URL?) async throws -> Image {
        guard let url = url else { throw URLError(.badURL) }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            return Image(uiImage: cachedImage)
        }
    
        let data = (try await downloadSession.data(from: url)).0
        
        guard let image = UIImage(data: data) else { throw URLError(.badServerResponse) }
            queue.async { self.imageCache.setObject(image, forKey: url.absoluteString as NSString) }
    
        return Image(uiImage: image)
    }
}
