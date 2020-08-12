import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Phone Auth demo📱",
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.network(
            "https://avatars1.githubusercontent.com/u/41328571?s=280&v=4",
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.phone_iphone,
                    color: Colors.cyan,
                  ),
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "Enter Your Phone Number...",
                  fillColor: Colors.white70),
              onChanged: (value) {
                phoneNumber = value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () =>
                phoneNumber == null ? null : verifyPhoneNumber(context),
            child: Text(
              "Generate OTP",
              style: TextStyle(color: Colors.white),
            ),
            elevation: 7.0,
            color: Colors.cyan,
          ),
          SizedBox(
            height: 20,
          ),
          Text("Need Help?")
        ],
      ),
    );
  }
}

String phoneNumber, verificationId;
String otp;

Future<void> verifyPhoneNumber(BuildContext context) async {
  final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
    verificationId = verId;
  };
  final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
    verificationId = verId;
    otpDialogBox(context).then((value) {
      print("Code Sent");
    });
  };
  final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
  final PhoneVerificationFailed verifyFailed = (AuthException e) {
    print('${e.message}');
  };
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    timeout: const Duration(seconds: 15),
    verificationCompleted: verifiedSuccess,
    verificationFailed: verifyFailed,
    codeSent: smsCodeSent,
    codeAutoRetrievalTimeout: autoRetrieve,
  );
}

otpDialogBox(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Enter your OTP'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30),
                  ),
                ),
              ),
              onChanged: (value) {
                otp = value;
              },
            ),
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                signIn(otp);
              },
              child: Text(
                'Submit',
              ),
            ),
          ],
        );
      });
}

Future<void> signIn(String otp) async {
  final AuthCredential credential = PhoneAuthProvider.getCredential(
    verificationId: verificationId,
    smsCode: otp,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);
}
