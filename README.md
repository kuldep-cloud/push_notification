# push_notification_demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- - [firebase_core](https://pub.dev/packages/firebase_core), which is required to use any Firebase service with Flutter
- [firebase_messaging](https://pub.dev/packages/firebase_messaging), which is used for receiving notifications in the app
- [awesome_notifications_fcm:](https://pub.dev/packages/awesome_notifications_fcm)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


What are push notifications?

    If you use a smartphone, you almost certainly encounter push notifications daily.
    Push notifications are clickable pop-up messages that appear on your users’ devices,
    regardless of whether they are using that particular app at the time.
    Even when the device is idle or the user is using another app,
    a user will receive push notifications as long as the device is online and notification permissions are granted.
    Push notifications can be used to inform a user of status updates, message requests, reminders, alerts, and more.

In this , we’ll use Firebase Cloud Messaging to send push notifications.

Setting up Firebase

    1.To start using Firebase, you have to create new Firebase project.
      Log into your Google account, navigate to the Firebase console, and click Add project:
    2.Enter a project name and click Continue:
    3.Disable Google Analytics; we don’t need it for our sample project. Then, click Create project:
    4.After the project initializes, click Continue:
    5.This will take you to the Project Overview screen. Here,
      you’ll find options to integrate the Firebase project with your Android and iOS app:


Integrate Firebase with Flutter: Android

To integrate your Firebase project with the Android side of the app, first,
click the Android icon on the project overview page:

    You should be directed to a form. First, enter the Android package name.
    You can find this in your project directory → android → app → src → main → AndroidManifest.xml. On the second line,
    you’ll see your package name. Just copy and paste it into the form.

    Optionally, you can choose a nickname for your app. If you leave this field empty,
    an auto-generated app name will be used:

    You’ll have to enter the SHA-1 hash. Just hover over the help icon ? and click on See this page,
    which will take you to the Authenticating Your Client page:

    From here, you’ll get the command to generate the SHA-1 hash. Paste this command into your terminal,
    then just copy and paste the generated SHA-1 hash into the form. Click Register app, which will take you to the next step.

    Download the google-services.json file, drag and drop it into your project directory → android → app, then,
    click Next:

    Follow the instructions and add the code snippets in the specified position. Then, click Next:

    Finally, click Continue to console: With this, you’ve completed the Firebase setup for the Android side of your app.

Integrate Firebase with Flutter: iOS

To integrate your Firebase project with the iOS side of your app, first,
click the Add app button on the project overview page, then select iOS:

    Enter the iOS bundle ID and your App nickname. Then, click Register app.
    You can leave the App store ID blank for now; you’ll get this when you deploy your app to the iOS App Store:

    You can find the bundle ID inside ios → Runner.xcodeproj → project.pbxproj by searching for PRODUCT_BUNDLE_IDENTIFIER:

    Next, select Download GoogleService-Info.plist:
 
    Open the ios folder of the project directory in Xcode.
    Drag and drop the file you downloaded into the Runner subfolder.
    When a dialog box appears, make sure the Copy items if needed of the Destination property is checked and Runner is selected in the Add to targets box.
    Then, click Finish:

Adding push notification functionality with Firebase Cloud Messaging

Now, it’s time for us to add the functionality for our push notifications.
To start using the Firebase Cloud Messaging service, intialize the methods:

Intialize the required method in main app
         
          //firebase initialization
          await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
       );


Request for permission

        static Future<void> initialize() async{

    //check notification permission for ios
    NotificationSettings settings=await FirebaseMessaging.instance.requestPermission();
     //checking authorization status
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      log("Notification Intialize");
    }
     }

Make a background handler function for checking background message.
Note: Mate sure intialize it Global.

              Future<void> backgroundHandler(RemoteMessage message) async{
                    log("message received from background! ${message.notification!.title}");
               }


OnMessage method for listening notification when app in on running state.

       FirebaseMessaging.onMessage.listen((message) {
      log("onmessage message received! ${message.notification!.title}");
    });

Used onMessageOpenedApp method when app is on background.
This method will run when your app in on background
Note:A Stream event will be sent if the app has opened from a background state (not terminated).

          FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("onMessageOpenedApp message received! ${message.notification!.title}");
    });