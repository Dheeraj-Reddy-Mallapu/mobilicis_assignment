# mobilicis_assignment by Dheeraj Reddy

## How to build and run the app?

-> Create a new flutter project.

-> Download or clone the mobilicis_assignment project from github and add lib and assets folder to your project.

-> Copy the dependencies from pubspec.yaml file to your pubspec.yaml file and save it to get all dependencies.

-> Using Flutterfire CLI, run 'flutterfire configure' command to connect the project to firebase (This step is necessary to make the notifications working).

-> In android - app - build.gradle file, change the minSdkVersion to 21.

-> You can now run ('flutter run' - command) the app by connecting your android device or android emulator.

## Cache

-> I have used cached_network_image package to manage image caching. It caches the image with the key being url.

## Architecture

-> I have created api service classes to manage the retrieval of the data from apis and created model object classes to efficently manage those data.

-> I have not used provider or any other state management tools as I did not see the need. Because the data is being used in only one or two widgets/ classes.

## Design decisions and its backend

-> As this is an assignment and being tasked to create Home screen, Filters UI and Search screen only, I have kept the rest of the widgets non-interactive.

Except for notifications screen. We can open the notifications screen by tapping notification icon on the top-right and view all the notifications.

## Notifications

-> I have created handlers to retieve both foreground and background notifications.

-> Also, made the notifications to be saved in the firestore (database).

-> To test/ recieve the notification, you have to compose notification in the firebase cloud messaging by providing fcmtoken that is generated after running the app.

-> To handle the click process when the user taps on a notification to navigate to a specific screen and to save the notification in the firestore, you have to provide custom data - {'screen': '/notifications', 'id': 'some id'}.

-> The implementation of saving of notification to firestore will be better from server side.
