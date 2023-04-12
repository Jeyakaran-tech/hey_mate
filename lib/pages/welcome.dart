// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hey_mate/components/my_button.dart';
import 'package:hey_mate/components/my_textfield.dart';
import 'package:hey_mate/widgets/google_sign_in_button.dart';
import 'package:hey_mate/utils/authentication.dart';
import 'package:hey_mate/pages/signup.dart';


class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final usernameController = TextEditingController();

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Image.network(
              //   'https://anmg-production.anmg.xyz/yaza-co-za_sfja9J2vLAtVaGdUPdH5y7gA',
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              //   fit: BoxFit.cover,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Color.fromARGB(255, 0, 0, 0),
                    onPressed: () {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                  const Text("Hi mate!",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 1)
                            .withOpacity(_opacity),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyTextField(
                                  controller: usernameController,
                                  hintText: 'Email',
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
                                MyButton(
                                  onTap: (() {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()),
                                      );
                                    } else {
                                      print('not valid');
                                    }
                                  }),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        'Or',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    
                                      SizedBox(height: 10),
                                      // google button
                                      FutureBuilder(
                                        future: Authentication.initializeFirebase(context: context),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text('Error initializing Firebase');
                                          } 
                                          else if (snapshot.connectionState == ConnectionState.done) {
                                              return GoogleSignInButton();
                                          }
                                        return CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        );
                                        },
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                         mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Don\'t have an account?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 71, 233, 133),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      const Text('Forgot Password?',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 71, 233, 133),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      
                                      )
                                      
                                    ]
                                  ),
                                )


                              ]
                            ),
                          )
                        ),
                      ),
                    ),

                  )
                ]
              )
            ],
          ),)
        ),
    );
  }
}