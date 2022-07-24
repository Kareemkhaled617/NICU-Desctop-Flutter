
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:nicu_desctop/resources/color_manger.dart';
import 'package:nicu_desctop/signup.dart';
import 'package:nicu_desctop/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var logger = Logger();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  bool pass = true;
   String? _emailController;
   String? _passwordController;
  bool? the = false;

  @override
  void initState() {
    the =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
    print(the);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: the!
                ? const AssetImage("assets/images/dark.jpg")
                : const AssetImage('assets/images/pg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Image(image: AssetImage('assets/images/frist.png')),
                    Text("WE HOPE TO BE HEALTHY".tr,
                        style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    buildTextFormField(
                        vall: false,
                        validate: () =>
                            (val) {
                          if (val!.isEmpty || !val.contains('@')) {
                            return "Invalid email!";
                          }
                          return null;
                        },
                        onSave: () =>
                            (val) {
                          setState(() {
                            _emailController = val;
                          });
                        },
                        hint: 'Enter Email'.tr,
                        label: 'Username'.tr,
                        pIcon: Icon(
                          Icons.person,
                          color: Get.isDarkMode
                              ? ColorManager.primary
                              : ColorManager.darkPrimary,
                        ),
                        sIcon: Icon(
                          Icons.verified_user_outlined,
                          color: Get.isDarkMode
                              ? ColorManager.primary
                              : ColorManager.darkPrimary,
                        ),
                        onTab: () {}),
                    const SizedBox(
                      height: 30.0,
                    ),
                    buildTextFormField(
                        vall: pass,
                        validate: () =>
                            (val) {
                          if (val!.isEmpty || val.length <= 5) {
                            return "Password is too short!";
                          }
                          return null;
                        },
                        onSave: () =>
                            (val) {
                          setState(() {
                            _passwordController = val;
                          });
                        },
                        hint: 'Password'.tr,
                        label: 'Password'.tr,
                        pIcon: Icon(
                          Icons.lock_outline,
                          color: Get.isDarkMode
                              ? ColorManager.primary
                              : ColorManager.darkPrimary,
                        ),
                        sIcon: Icon(
                          Icons.remove_red_eye_rounded,
                          color: Get.isDarkMode
                              ? ColorManager.primary
                              : ColorManager.darkPrimary,
                        ),
                        onTab: () {
                          setState(() {
                            pass = !pass;
                          });
                        }),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MyButton(
                      title: 'Login'.tr,
                      onTap:()async {
                        _submit();
                      },
                      color: Colors.white,
                      color1: Get.isDarkMode
                          ? ColorManager.primary
                          : ColorManager.darkPrimary,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            endIndent: 5,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'OR',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            indent: 5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create a new account?'.tr,
                          style: GoogleFonts.arimo(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? ColorManager.darkGrey
                                : ColorManager.white,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Sign_Up()));
                            },
                            child: Text(
                              'Register Now'.tr,
                              style: GoogleFonts.abel(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future save_data()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', true);
  }

  TextFormField buildTextFormField({
    required String hint,
    required String label,
    required Widget pIcon,
    required Widget sIcon,
    required Function() onTab,
    required Function() validate,
    required Function() onSave,
    required bool vall,
  }) {
    return TextFormField(
      validator: validate(),
      onSaved: onSave(),
      // keyboardType: TextInputType.visiblePassword,
      obscureText: vall,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.arimo(
          fontSize: 20,
          color: Colors.grey[700],
        ),
        hintText: hint,
        hintStyle: GoogleFonts.arimo(
          fontSize: 19,
          color: Colors.grey[700],
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black, width: 1.2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black, width: 1.2)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.black, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: pIcon,
        suffixIcon: IconButton(
          onPressed: onTab,
          icon: sIcon,
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      dynamic signUpResult = await _firebaseAuthService.signIn(_emailController!,_passwordController!);
      if (signUpResult != null && !signUpResult.toString().contains("AuthException:")) {
        logger.i("SignIn Success");
        Get.offAll(const MyHomePage());
        save_data();
      } else {
        // _firebaseSignInErrorAlert(context);
        logger.e(signUpResult.toString());
      }
    }
  }





}