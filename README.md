# MealsApp

Victor Isaac Dimas Moreno 

Meals App is an app where you can look up for the best meals recipes, in there you can find the ingredients, measures, instructions and youtube video tutorial (if existing) of many different kinds of meals like pasta, beef, etc.
In Meals App you can also track a schedule in a calendar where you can put on the meals that you were looking for.

# Installation

Go the path where the Podfile is in the terminal and execute the pod install command
The app was tested in Xcode 14.3 and supports iOS 16+ because of the SwiftUI features that were used

# Features in the Meals App
- Dashboard Module

    The app has a main dashboard section in which the user can see the week specialty (Desserts by default) and also look up for other meal categories, and also the user can see the detail of those meals.

- Search Module

  The user can look up for meals depending of a category selected and filter them in a searchbar when the user types something.

- Tracking Food Calendar Module
  
  The user can look up for recipes in this section and added as an event to the calendar, also the user can access to the recipe saved in that particular day for showing the detail of the meal.

# Frameworks used in the Meals App

- UIKit

  For the dashboard views and the TabBar. (Programmatic UI, NOT INTERFACE BUILDER)
  
- SwiftUI

  For the Search and Calendar modules and the intro sliding cards

- Combine

  For binding the variables that were used in the SwiftUI views

- XCTest

  For unit testing

- Lottie

  For the intro of the App

- Youtube Helper

  For the youtube videos in the detail view of the meal


# More Technical features

- JSONDecoder and JSONSerialization used for parsing the data of the API
- Dedicated Networking layer
- Cache for UIImageView
- Management of memory leaks with [weak self]
- Added Coordinator pattern for the AppDelegate for controling inital view instances
- Added Delegate pattern for comunicating objects through the app
- Added Unit Testing for the networking layer applying AAA pattern (Arrange, Act, Assert)
- Added MVP architecture for the UIKit views
- Added MVVM architecture for the SwiftUI views
- Added reusable views like the detail view of the meal
- Added custom font for the text in the app
- Added extensions of the different objects in Foundatin, UIKit and SwiftUI for reusing code
- Applied GitFlow for this repo by using the pattern Main -> Dev -> Task
