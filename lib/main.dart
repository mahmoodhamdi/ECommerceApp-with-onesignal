import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_signal_guide/firebase_options.dart';
import 'package:one_signal_guide/screens/category_display_screen.dart';
import 'package:one_signal_guide/screens/home_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'screens/intro_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('c74472b4-a612-4403-b295-1502304b2174');
  OneSignal.Notifications.requestPermission(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigationKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? screen;
    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      if (data != null) {
        screen = data['screen'];
      }
      if (screen != null) {
        navigationKey.currentState?.pushNamed(screen!);
      }
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ECommerceApp',
      navigatorKey: navigationKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/categoryScreen': (context) => const CategoryDisplayScreen(),
      },
    );
  }
}
