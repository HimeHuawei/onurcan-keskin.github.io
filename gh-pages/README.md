# Flutter Sign In Codelab Complex - Simple Build

Flutter codelab with Huawei Account Kit

## Table of Contents

*  [Introduction](#introduction)
*  [Installation](#installation)
*  [Configuration](#configuration)
*  [Supported Environments](#supported-environments)
*  [Sample Code](#sample-code)
*  [Contributors](#contributors)
*  [License](#license)

## Introduction

HMS Account Kit Flutter Codelab code encapsulates APIs of the Huawei. It provides two samples one with full logdislay and other one with complex form display.
Before you using this codelab, it's assumed that you already have HUAWEI developer account and also already created an app to implement Flutter HMS Account Kit. If you haven't please refer to [BasicServices](https://developer.huawei.com/consumer/en/doc/start/introduction-0000001053446472), [AppGallery ConnectIntroduction](https://developer.huawei.com/consumer/en/doc/development/AppGallery-connect-Guides/agc-introduction)

    functions   :   The package name which refers to a account object.
    screens     :   The package name which shows the interface screens of the app to the user.
    utils       :   The package which helps the shared preferences and email validation on sign in actions.
    widgets     :   The package which designs the custom ui elements for the app for users to interact. 
    
## Installation

Before using Flutter HMS Account Kit Codelab code, check whether the Android Studio environment has been installedand Flutter doctor correctly configured.
Download the Flutter HMS Account Kit Codelab project by zip or clone from Github.
Wait for the gradle build in your project.

## Configuration

   1. Register and sign in to HUAWEI Developers.
   2. Create a project and then create an app in the project, enter the project package name.
   3. Go to Project Settings > Manage APIs, find the Account Kit API, and enable it.
   4. Go to Project Settings > General information, click Set next to Data storage location under Project information, and select a data storage location in the displayed dialog box.
   5. Download the agconnect-services.json file and place it to the app's root directory of the project.
   6. Add the Maven repository address maven {url 'https://developer.huawei.com/repo/'} and plug-in class path 'com.huawei.agconnect:agcp:1.4.1.300' to the project-level build.gradle file.
   7. Add apply plugin: 'com.huawei.agconnect' to the last line of the app-level build.gradle file.
   8. Configure the dependency from [here](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Library/flutter-sdk-download-0000001051088628) in the app-level buildle.gradle file or under pubsec.yaml add dependencies:
   huawei_account: ^5.0.3+303.
   9. Synchronize the project by running this on terminal $ flutter pub get.

## Supported Environments

* •	Android Studio 3.x or later version
* •	Java JDK 1.8 or later version
* •	EMUI 3.0 or later version
* •	HMS Core (APK) 5.0.0.300 or later version


## Sample Code

1. Setting Welcome Screen as our Main Screen
This screen wil start our app with Welcome Screen
Code Location [lib/main.dart](https://git.huawei.com/hms---turkey-dtse-branch/flutter-sign-in-codelab/blob/master/lib/main.dart)

2.  Creating Huawei Auth Buttons
This button will help us to create new user by using Container elements
Code Location [lib/widgets/auth_button.dart](https://git.huawei.com/hms---turkey-dtse-branch/flutter-sign-in-codelab/blob/master/lib/widgets/auth_button.dart)

3.  Creating Rich Buttons with Images to direct to either Simple or Complex Builds
This custom button will help us create text with images that resides on left margin.
Code location [lib/widgets/auth_rich_button.dart](https://git.huawei.com/hms---turkey-dtse-branch/flutter-sign-in-codelab/blob/master/lib/widgets/auth_rich_button.dart)

4. Creating Welcome Screen
This screen will aid us to either navigate to simple screen or complex form screen.
Code Location [lib/screens/welcome_screen.dart](https://git.huawei.com/hms---turkey-dtse-branch/flutter-sign-in-codelab/blob/master/lib/screens/welcome_screen.dart)

5.  Simple Screen
This is an example that we can login with [Huawei Account Kit](https://developer.huawei.com/consumer/en/hms/huawei-accountkit/) to see the full log events.

6.  Complex Form Screen
This is the classical example of sign in or register form that users can take example of with email login with shared preferences from [lib/util/shared_prefs.dart](https://git.huawei.com/hms---turkey-dtse-branch/flutter-sign-in-codelab/blob/master/lib/util/shared_prefs.dart) or login with [Huawei Account Kit](https://developer.huawei.com/consumer/en/hms/huawei-accountkit/).
Code Location [lib/screens/email_auth_screen.dart](https://git.huawei.com/hms---turkey-dtse-branch/flutter-sign-in-codelab/blob/master/lib/screens/email_auth_screen.dart)

## Libraries

- [Huawei Account Kit](https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/introduction-0000001050766441)

## Contributors

- Onurcan Keskin

## License
    
HMS Account Kit Codelab is licensed under the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).