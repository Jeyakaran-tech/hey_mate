import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hey_mate/utils/authentication.dart';
import 'package:hey_mate/pages/user_info_screen.dart';
import 'package:hey_mate/pages/after_sign_in_screen.dart';
import 'package:hey_mate/components/square_tile.dart';



class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), 
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User? user = await Authentication.signInWithGoogle(context: context);
                
                setState(() {
                  _isSigningIn = false;
                });
                
                if (user != null && context.mounted) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AfterSigninScreen(),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SquareTile(imagePath: "assets/images/google.png", title: "Sign in with Google")
                  ],
                ),
              ),
            ),
    );
  }
}