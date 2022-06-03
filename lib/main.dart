import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/auth/login_screen.dart';
import 'package:flutter_blood_bank_app/auth/register_screen.dart';
import 'package:flutter_blood_bank_app/doctors/doctor_details.dart';
import 'package:flutter_blood_bank_app/home/home_screen.dart';
import 'package:flutter_blood_bank_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context)=> AuthProvider(),
      child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme:const AppBarTheme(
          color: Colors.transparent,
          centerTitle: true ,
          elevation: 0
        )
      ),
      routes: {
        RegisterScreen.ROUTE_NAME:(context) => RegisterScreen(),
        LoginScreen.ROUTE_NAME : (context) => LoginScreen(),
        HomeScreen.ROUTE_NAME : (context)=> HomeScreen(),
        DoctorDetailsScreen.ROUTE_NAEM : (context)=> DoctorDetailsScreen(),
      },
      initialRoute: HomeScreen.ROUTE_NAME,
    );
  }
}

