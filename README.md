## Description

This project composes of two main components - front-end (mobile application) and back-end (node.js application)

## Fronted-end installation

This project is a starting point for a Flutter application.
1. Download the following installation bundle to get the latest stable release of the Flutter SDK:  
    https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.3.10-stable.zip
2. Extract the zip file and place the contained flutter in the desired installation location for the Flutter SDK (for example, C:\src\flutter).

## Update your path
If you wish to run Flutter commands in the regular Windows console, take these steps to add Flutter to the PATH environment variable:

From the Start search bar, enter ‘env’ and select Edit environment variables for your account.
Under User variables check if there is an entry called Path:
    If the entry exists, append the full path to flutter\bin using ; as a separator from existing values.
    If the entry doesn’t exist, create a new user variable named Path with the full path to flutter\bin as its value.
  
 ## Run flutter doctor
 
  ```shell
  flutter doctor	
  ```
  
  This command checks your environment and displays a report of the status of your Flutter installation. Check the output carefully for other software you might      need   to install or further tasks to perform (shown in bold text).

  ```shell
  [-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
    • Try re-installing or updating your Android SDK,
      visit https://docs.flutter.dev/setup/#android-setup for detailed instructions.
	
  ```
  
  
## Install Android Studio
1. Download and install Android Studio by this link https://developer.android.com/studio
2. Start Android Studio, and go through the ‘Android Studio Setup Wizard’. This installs the latest Android SDK, Android SDK Command-line Tools, and Android SDK  Build-Tools, which are required by Flutter when developing for Android.
3. .Run flutter doctor to confirm that Flutter has located your installation of Android Studio. If Flutter cannot locate it, run flutter config --android-studio-dir (directory) to set the directory that Android Studio is installed to.
  
## Set up the Android emulator
To prepare to run and test your Flutter app on the Android emulator, follow these steps:
1. Enable VM acceleration on your machine.
2. Launch Android Studio, click the AVD Manager icon, and select Create Virtual Device…
    - In older versions of Android Studio, you should instead launch Android Studio > Tools > Android > AVD Manager and select Create Virtual Device…. (The Android       submenu is only present when inside an Android project.)
    - If you do not have a project open, you can choose Configure > AVD Manager and select Create Virtual Device…
3. Choose a device definition and select Next
4. Select one or more system images for the Android versions you want to emulate, and select Next. An x86 or x86_64 image is recommended
5. Under Emulated Performance, select Hardware - GLES 2.0 to enable hardware acceleration.
6. Verify the AVD configuration is correct, and select Finish.
7. In Android Virtual Device Manager, click Run in the toolbar. The emulator starts up and displays the default canvas for your selected OS version and device.


## Agree to Android Licenses
Before you can use Flutter, you must agree to the licenses of the Android SDK platform. This step should be done after you have installed the tools listed above.

1. Make sure that you have a version of Java 8 installed and that your JAVA_HOME environment variable is set to the JDK’s folder.
    Android Studio versions 2.2 and higher come with a JDK, so this should already be done.
2. Open an elevated console window and run the following command to begin signing licenses
 
  ```shell
  flutter doctor --android-licenses	
  ```
3. Review the terms of each license carefully before agreeing to them.
4. Once you are done agreeing with licenses, run flutter doctor again to confirm that you are ready to use Flutter.

 
  


  


  
