import 'package:awesome_notifications/awesome_notifications.dart';
import 'church/presentation/screens/get_started_screen/get_started_screen.dart';
import 'package:chruch/church/presentation/screens/layout_screen/layout_screen.dart';
import 'package:chruch/church/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'church/presentation/screens/sign_in_screen/login_screen.dart';
import 'core/global/components/components.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/network/local/cache_helper.dart';
import 'core/services/sevices_locator.dart';
import 'core/utils/app_constance.dart';
import 'core/utils/user_Contstance.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Future<void> onFirebaseMessageReceived(RemoteMessage message) async {
//
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 0,
//       channelKey: 'basic_channel',
//       title: message.notification!.title,
//       body: message.notification!.body,
//       notificationLayout: NotificationLayout.BigPicture,
//       largeIcon: 'notification_icon',
//       bigPicture: message.notification?.android?.imageUrl,
//     ),
//     actionButtons: [
//       NotificationActionButton(
//         label: 'قبول',
//         key: 'acc',
//       ),
//       NotificationActionButton(
//         label: 'رفض',
//         key: 'dis',
//       ),
//     ],
//     schedule: NotificationCalendar(
//       second: 1,
//     ),
//
//   );
// }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint(message.data.toString());
//
//   toastShow(text: 'on message background handler', state: ToastStates.success);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // print(await FirebaseMessaging.instance.getToken() ?? 'noooooooooo');

  // FirebaseMessaging.onMessage.listen((event) {
  //   toastShow(text: 'on message', state: ToastStates.success);
  //   debugPrint(event.data.toString());
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   toastShow(text: 'on message opened app', state: ToastStates.success);
  //   debugPrint(event.data.toString());
  // });
  // FirebaseMessaging.onBackgroundMessage(onFirebaseMessageReceived);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // await FirebaseMessaging.instance.subscribeToTopic('primary_class');

  // await FirebaseMessaging.instance.sendMessage(to: 'primary_class',data: {'hello':'world'}, messageType: 'primary_class', ttl: 1, collapseKey: 'primary_class', messageId: 'primary_class');
  ServicesLocator().init();
  await CacheHelper.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  UserConstance.isUserDataSaved = CacheHelper.getData(key: 'isUserDataSaved');
  if (UserConstance.isUserDataSaved??false) await getUserDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Church',
      theme: lightTheme,
      home: const SplashScreen(),
    );
  }
}
