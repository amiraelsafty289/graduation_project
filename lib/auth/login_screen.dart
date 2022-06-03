import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/auth/register_screen.dart';
import 'package:flutter_blood_bank_app/data/firestore_utils.dart';
import 'package:flutter_blood_bank_app/home/home_screen.dart';
import 'package:flutter_blood_bank_app/provider/auth_provider.dart';
import 'package:flutter_blood_bank_app/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String ROUTE_NAME = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '', password = '';
  late AuthProvider provider ;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     provider = Provider.of<AuthProvider>(context);
    return Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/background.png',
              )),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Login Screen',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .25,
                    ),
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter email';
                          }
                          if (!isValidEmail(email)) {
                            return 'please enter a valid email';
                          }
                          return null;
                        }),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      onChanged: (text) {
                        password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (text.length < 6) {
                          return 'password should be at least 6 chars';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          loginWithFirebaseAuth();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          Navigator.pushNamed(context, RegisterScreen.ROUTE_NAME);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
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
  void loginWithFirebaseAuth() async {
    try {
      showLoading(context);

      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      hideLoading(context);
      if (result.user != null) {
        showMessage('user Logged in successfully', context);
        // retrieve user from DB
        var firestoreUser = await getUserById(result.user!.uid);
        if (firestoreUser != null) {
          // save user in provider
          provider.updateUser(firestoreUser);
          Navigator.pushReplacementNamed(context, HomeScreen.ROUTE_NAME);
        }
      }

    } catch (error) {
      hideLoading(context);
      showMessage('invalid email or password', context);
    }
  }
}
