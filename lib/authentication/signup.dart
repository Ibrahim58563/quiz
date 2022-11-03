import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/screens/main_screen.dart';
import '../components/constants.dart';
import '../components/header_animation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? repeatPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            HeaderAnimation(),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(child: title(context)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                customTextField(
                                  controller: firstNameController!,
                                  hintText: 'Enter your First Name',
                                  labelText: 'First Name',
                                  prefixIcon: Icons.person,
                                  isSecured: false,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                customTextField(
                                  controller: lastNameController!,
                                  hintText: 'Enter your Last Name',
                                  labelText: 'Last Name',
                                  prefixIcon: Icons.person,
                                  isSecured: false,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                customTextField(
                                  controller: emailController!,
                                  hintText: 'Enter your Email',
                                  labelText: 'Email',
                                  prefixIcon: Icons.email,
                                  isSecured: false,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                customTextField(
                                  controller: passwordController!,
                                  hintText: 'Enter your Password',
                                  labelText: 'Password',
                                  prefixIcon: Icons.lock,
                                  isSecured: true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                customTextField(
                                  controller: repeatPasswordController!,
                                  hintText: 'Re-Enter your Password',
                                  labelText: 'Password',
                                  prefixIcon: Icons.lock,
                                  isSecured: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          customButton(
                            context,
                            'Sign Up',
                            Colors.transparent,
                            Colors.orange,
                            Colors.white,
                            // LoginPage(),
                            onPressed: () async {
                              try {
                                print("email:${emailController!.text}");
                                print("password:${passwordController!.text}");
                                UserCredential user = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                        email: emailController!.text,
                                        password: passwordController!.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                          SizedBox(height: height * .01),
                          loginAccountLabel(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
