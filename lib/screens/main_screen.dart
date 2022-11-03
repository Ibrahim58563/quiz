import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('MainScreen'),
            Text(FirebaseAuth.instance.currentUser!.displayName!),
            Text(FirebaseAuth.instance.currentUser!.email!),
          ],
        ),
      ),
    );
  }
}
