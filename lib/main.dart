import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_example/homePage.dart';
import 'package:phone_auth_example/signup_screen.dart';
import 'package:provider/provider.dart';

import './signUpPage.dart';
import './user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          // ignore: deprecated_member_use
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return HomePage();
            } else if (userSnapshot.hasError) {
              return CircularProgressIndicator();
            }
            return LoginPage();
          },
        ),
        routes: {
          SignupScreen.routeName: (ctx) => SignupScreen(),
        },
      ),
    );
  }
}
