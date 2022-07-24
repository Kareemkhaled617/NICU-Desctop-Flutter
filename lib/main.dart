import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'login.dart';

const apiKey = "AIzaSyCGxQIpOdcAQrKwOM6foW4KNLRAhjiD5As";
const projectId = "nicu-aaa44";

FirebaseOptions get firebaseOptions => const FirebaseOptions(
      apiKey: 'AIzaSyCGxQIpOdcAQrKwOM6foW4KNLRAhjiD5As',
      authDomain: 'nicu-aaa44.firebaseapp.com',
      projectId: 'nicu-aaa44',
      storageBucket: 'nicu-aaa44.appspot.com',
      messagingSenderId: '164392202363',
      appId: '1:164392202363:web:3e81c63a20f0e71ac3f2de',
      measurementId: 'G-0XKJ4C2YL0',
    );
bool isLogin = false;

Future get_data() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getBool('status') ?? false;
  return prefs.getBool('status');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  Firestore.initialize(projectId);
  FirebaseAuth.initialize(apiKey, VolatileStore());
  get_data();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      home: OverlaySupport(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
           home:isLogin? const MyHomePage():const LoginPage(),
          // home: MyHomePage(),
        ),
      ),
    );
  }
}
