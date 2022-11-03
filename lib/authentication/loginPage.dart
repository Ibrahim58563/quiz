import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/constants.dart';
import '../components/header_animation.dart';
import '../screens/main_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool visiblePassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100000;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          const HeaderAnimation(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Center(child: title(context)),
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    customTextField(
                        prefixIcon: Icons.email,
                        controller: emailController!,
                        hintText: 'Enter your Email',
                        labelText: 'Email',
                        isSecured: false),
                    SizedBox(height: 20),
                    customTextField(
                      isSecured: true,
                      prefixIcon: Icons.lock,
                      enableSuffixIcon: Icons.remove_red_eye,
                      disableSuffixIcon: Icons.visibility_off,
                      controller: passwordController!,
                      hintText: 'Enter your Password',
                      labelText: 'Password',
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    SizedBox(height: 50),
                    customButton(
                      context,
                      'Login',
                      Colors.transparent,
                      Colors.orange,
                      Colors.white,
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                            email: emailController!.text,
                            password: passwordController!.text,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password ?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    divider(),
                    googleButton(
                      onPressed: () async {
                        await signInWithGoogle();
                      },
                    ),
                    SizedBox(height: height * .055),
                    createAccountLabel(context),
                  ],
                ),
              ),
              // Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    UserCredential authResult =
        await _auth.signInWithCredential(authCredential);
    User? user = authResult.user;
    print('user email = ${user!.email}');
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
