import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'church/presentation/screens/get_started_screen/get_started_screen.dart';
import 'core/global/components/components.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/network/local/cache_helper.dart';
import 'core/services/sevices_locator.dart';
import 'core/utils/app_constance.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  print(message.data);

  toastShow(text: 'on message background handler', state: ToastStates.success);
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(await FirebaseMessaging.instance.getToken()??'noooooooooo');

  FirebaseMessaging.onMessage.listen((event) {
    toastShow(text: 'on message', state: ToastStates.success);
    print(event.data);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    toastShow(text: 'on message opened app', state: ToastStates.success);
    print(event.data);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.subscribeToTopic('primary_class');
  // await FirebaseMessaging.instance.sendMessage(to: 'primary_class',data: {'hello':'world'}, messageType: 'primary_class', ttl: 1, collapseKey: 'primary_class', messageId: 'primary_class');
  ServicesLocator().init();
  await CacheHelper.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  AppConstance.uId = CacheHelper.getData(key: 'uId');
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
      home: const GetStartedScreen(),
    );
  }
}
