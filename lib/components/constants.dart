import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/authentication/loginPage.dart';
import 'package:quiz_app/authentication/signup.dart';

bool passwordVisible = true;

Widget customButton(
  BuildContext context,
  String text,
  Color borderColor,
  Color buttonColor,
  Color textColor, {
  void Function()? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: textColor),
      ),
    ),
  );
}

Widget title(BuildContext context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'q',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline1,
          fontSize: 60,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        children: [
          TextSpan(
            text: 'ui',
            style: TextStyle(color: Colors.black, fontSize: 50),
          ),
          TextSpan(
            text: 'z',
            style: TextStyle(color: Colors.white, fontSize: 60),
          ),
        ]),
  );
}

Widget customTextField({
  required TextEditingController controller,
  TextInputType? keyboardType,
  required String hintText,
  required String labelText,
  String? validatorText,
  IconData? prefixIcon,
  IconData? disableSuffixIcon,
  IconData? enableSuffixIcon,
  final VoidCallback? onPressed,
  required bool isSecured,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: isSecured,
    validator: (value) {
      if (value!.isEmpty) {
        return validatorText;
      }
      return null;
    },
    decoration: InputDecoration(
      focusColor: Colors.orange,
      fillColor: Colors.orange,
      prefixIconColor: Colors.orange,
      suffixIconColor: Colors.orange,
      labelStyle: TextStyle(color: Colors.orange),
      hoverColor: Colors.orange,
      hintText: hintText,
      labelText: labelText,
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
      // floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(
        icon: passwordVisible == true
            ? Icon(enableSuffixIcon)
            : Icon(enableSuffixIcon),
        onPressed: onPressed,
      ),
    ),
  );
}

Widget divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        Text('or'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

Widget googleButton({void Function()? onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(241, 177, 45, 45),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('G',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(240, 210, 79, 79),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Google',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget createAccountLabel(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUpPage()));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Register',
            style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

Widget loginAccountLabel(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Login',
            style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
