import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'login.dart';

const apiKey = "AIzaSyDPFGG_vFM1WgPnPZtYNWNgHfX3Y-F3usA";
const projectId = "project-e8203";

FirebaseOptions get firebaseOptions => const FirebaseOptions(
      apiKey: 'AIzaSyDPFGG_vFM1WgPnPZtYNWNgHfX3Y-F3usA',
      authDomain: 'project-e8203.firebaseapp.com',
      projectId: 'project-e8203',
      storageBucket: 'project-e8203.appspot.com',
      messagingSenderId: '562455088953',
      appId: '1:562455088953:web:89e5004fa3ae828351a2e8',
      measurementId: 'G-WV186Q0NVT',
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
