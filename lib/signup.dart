import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:nicu_desctop/home_page.dart';
import 'package:nicu_desctop/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../resources/color_manger.dart';
import 'auth.dart';
import 'login.dart';

class Sign_Up extends StatefulWidget {
  Sign_Up({Key? key}) : super(key: key);

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var logger = Logger();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  String _signInError = "";
  late String _emailController;
  late String _passwordController;
  String? _hospitalController;
  String? _nameController;
  CollectionReference? addUser;
  // String? user ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Image(image: AssetImage('assets/images/frist.png')),
                    const Text('WE HOPE TO BE HEALTHY',
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    const SizedBox(
                      height: 15.0,
                    ),
                    buildTextFormField(
                        type: TextInputType.name,
                        onSave: () => (val) {
                              setState(() {
                                _nameController = val;
                              });
                              print(_nameController);
                            },
                        validate: () => (val) {
                              if (val!.isEmpty) {
                                return "Invalid Name!";
                              }
                              return null;
                            },
                        hint: 'Name',
                        label: 'Name',
                        pIcon: Icon(
                          Icons.person,
                          color: ColorManager.primary,
                        ),
                        sIcon: Icon(
                          Icons.verified,
                          color: ColorManager.primary,
                        ),
                        vall: false),
                    const SizedBox(
                      height: 20.0,
                    ),
                    buildTextFormField(
                        type: TextInputType.number,
                        onSave: () => (val) {
                          _hospitalController = val;
                            },
                        validate: () => (val) {
                              if (val!.isEmpty) {
                                return "Empty Data!";
                              }
                              return null;
                            },
                        hint: 'Hospital ID',
                        label: 'Hospital ID',
                        pIcon: Icon(
                          Icons.info,
                          color: ColorManager.primary,
                        ),
                        sIcon: Icon(
                          Icons.verified,
                          color: ColorManager.primary,
                        ),
                        vall: false),
                    const SizedBox(
                      height: 20.0,
                    ),
                    buildTextFormField(
                        type: TextInputType.emailAddress,
                        onSave: () => (val) {
                              setState(() {
                                _emailController = val;
                              });
                              print(_emailController);
                            },
                        validate: () => (val) {
                              if (val!.isEmpty || !val.contains('@')) {
                                return "Invalid email!";
                              }
                              return null;
                            },
                        hint: 'Email',
                        label: 'Email',
                        pIcon: Icon(
                          Icons.email_outlined,
                          color: ColorManager.primary,
                        ),
                        sIcon: Icon(
                          Icons.verified,
                          color: ColorManager.primary,
                        ),
                        vall: false),
                    const SizedBox(
                      height: 20.0,
                    ),
                    buildTextFormField(
                        type: TextInputType.visiblePassword,
                        validate: () => (val) {
                              if (val!.isEmpty || val.length <= 8) {
                                return "Password is too short!";
                              }
                              return null;
                            },
                        onSave: () => (val) {
                              setState(() {
                                _passwordController = val;
                              });
                              print(_passwordController);
                            },
                        hint: 'Password',
                        label: 'Password',
                        pIcon: Icon(
                          Icons.lock_outline,
                          color: ColorManager.primary,
                        ),
                        sIcon: Icon(
                          Icons.remove_red_eye,
                          color: ColorManager.primary,
                        ),
                        vall: true),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    MyButton(
                        title: 'Sign Up',
                        color: Colors.white,
                        onTap: () async {
                          _submit();
                        },
                        color1: ColorManager.primary),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Have An Account',
                          style: GoogleFonts.arimo(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.darkGrey,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                            },
                            child: Text(
                              'Login Now',
                              style: GoogleFonts.abel(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
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

  TextFormField buildTextFormField({
    required String hint,
    required String label,
    required Widget pIcon,
    required Widget sIcon,
    required TextInputType type,
    // required Function() onTab,
    required Function() validate,
    required Function() onSave,
    required bool vall,
  }) {
    return TextFormField(
      keyboardType: type,
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
          onPressed: () {},
          icon: sIcon,
        ),
      ),
    );
  }


  // signUp() async {
  //   try {
  //     if (_emailController.isNotEmpty &&
  //         _passwordController.isNotEmpty &&
  //         _nameController!.isNotEmpty &&
  //         _phoneController!.isNotEmpty) {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(
  //               email: _emailController, password: _passwordController);
  //       return userCredential;
  //     } else {
  //       print('isEmpty');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       AwesomeDialog(
  //         context: context,
  //         dialogType: DialogType.INFO,
  //         animType: AnimType.BOTTOMSLIDE,
  //         title: 'Attend  !',
  //         desc: 'The password is weak',
  //         btnCancelOnPress: () {},
  //         btnOkOnPress: () {},
  //       ).show();
  //     } else if (e.code == 'email-already-in-use') {
  //       AwesomeDialog(
  //         context: context,
  //         dialogType: DialogType.INFO,
  //         animType: AnimType.BOTTOMSLIDE,
  //         title: 'Attend  !',
  //         desc: 'This Account is Already Exist',
  //         btnOkOnPress: () {},
  //       ).show();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  Future save_data()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', true);
  }
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      dynamic signUpResult = await _firebaseAuthService.signUp(_emailController,_passwordController);
      if (signUpResult != null && !signUpResult.toString().contains("AuthException:")) {
        logger.i("SignUp Success");
        await addDataEmail(_hospitalController!);
        Get.offAll(const MyHomePage());
        save_data();
      } else {
        _signInError = signUpResult.toString();
        // _firebaseSignInErrorAlert(context);
        logger.e(signUpResult.toString());
      }

      return;
    } else {
      print('Not Valid');
    }
  }
  addDataEmail(String id) async {
    var addUser = Firestore.instance.collection('hospital').document(id);
    addUser.set({
      'Email': _emailController,
      'Username': _nameController,
      'Hospital': _hospitalController,
      'ID': id,
      'Image': 'null'
    });
    print('added');
  }



}
