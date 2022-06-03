import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/bottom_sheet/diabetic_type_bottom_sheet.dart';
import 'package:flutter_blood_bank_app/bottom_sheet/location_bottom_sheet.dart';
import 'package:flutter_blood_bank_app/data/firestore_utils.dart';
import 'package:flutter_blood_bank_app/home/home_screen.dart';
import 'package:flutter_blood_bank_app/provider/auth_provider.dart';
import 'package:flutter_blood_bank_app/utils.dart';
import 'package:flutter_blood_bank_app/data/user.dart' as AppUser;
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static String ROUTE_NAME = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String age = '';
  String userName = '',
      email = '',
  address = '',
      sex = '',
      password = '',
      location = '',
      diabeticType = '';

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
              'Register Screen',
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
                      height: MediaQuery.of(context).size.height * .20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'User Name'),
                      onChanged: (text) {
                        userName = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter Name';
                        }
                        return null;
                      },
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
                        decoration: InputDecoration(labelText: 'Age'),
                        onChanged: (text) {
                          age = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Age';
                          }
                          return null;
                        }),
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Sex'),
                        onChanged: (text) {
                          sex = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Sex';
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
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(labelText: 'Address'),
                      onChanged: (text) {
                        address = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter address';
                        }
                        return null;
                      },
                    ),
                    InkWell(
                      onTap: (){
                        showLocationBottomSheet();
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(location.isEmpty? 'Location' : location,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down , size: 30, color: Colors.black,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        showDiabeticTypeBottomSheet();
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(diabeticType.isEmpty ?'Diabetic Type':diabeticType,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              ),
                            ),
                            Icon(Icons.arrow_drop_down , size: 30, color: Colors.black,)
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          createAccountWithFirebaseAuth();
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
                          'Sign Up',
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
  onLocationChanged(String newLocation){
    location = newLocation;
    setState(() {});
  }
  onDiabeticTypeChanged(String newDiabeticType){
    diabeticType = newDiabeticType ;
    setState(() {

    });
  }
  void createAccountWithFirebaseAuth() async {
    try {
      showLoading(context);
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // to register user in our database
      hideLoading(context);
      if (result.user != null) {
        showMessage('User Registered Successfully', context);
        var myUser = AppUser.User(
            id: result.user!.uid,
            age: age,
            userName: userName,
            email: email,
          sex: sex,
          location: location,
          diabeticType: diabeticType,
          address: address
        );
        addUserToFireStore(myUser).then((value) {
          provider.updateUser(myUser);
          Navigator.pushReplacementNamed(context, HomeScreen.ROUTE_NAME);
        }).onError((error, stackTrace) {
          showMessage(error.toString(), context);
        });
      }
    } catch (error) {
      hideLoading(context);
      showMessage(error.toString(), context);
    }
  }
  void showLocationBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return LocationBottomSheet(location: location, onLocationChanged: onLocationChanged);
        });
  }
  void showDiabeticTypeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return DiabeticTypeBottomSheet(diabeticType: diabeticType , onDiabeticTypeChanged: onDiabeticTypeChanged);
        });
  }
}


