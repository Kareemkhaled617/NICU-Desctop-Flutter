import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'login.dart';

const apiKey = "AIzaSyAVpOw_Qfwu8HthT7DiuHCA0oSq6B7hR8U";
const projectId = "nicu-a74c1";

FirebaseOptions get firebaseOptions => const FirebaseOptions(
    apiKey: "AIzaSyAVpOw_Qfwu8HthT7DiuHCA0oSq6B7hR8U",
    authDomain: "nicu-a74c1.firebaseapp.com",
    projectId: "nicu-a74c1",
    storageBucket: "nicu-a74c1.appspot.com",
    messagingSenderId: "257892270258",
    appId: "1:257892270258:web:aae7fb73daa665b264c9ab",
    measurementId: "G-D1PFZBQ1H2"
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
      home: const OverlaySupport(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
           home:LoginPage(),
          // home: MyHomePage(),
        ),
      ),
    );
  }
}
