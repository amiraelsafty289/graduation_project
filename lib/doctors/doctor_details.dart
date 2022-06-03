import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/data/doctors.dart';

class DoctorDetailsScreen extends StatelessWidget {
  static String ROUTE_NAEM = 'doctor_details';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Doctor ;
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
                title: Text('Doctor Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 30),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network('${args.image}',
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                  Text('Name : ${args.name}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Age : ${args.age}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Address : ${args.address}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Degree : ${args.degree}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Governorate : ${args.governorate}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                            )
                        )),
                        onPressed: (){
                        },
                        child: Text('Book',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white
                          ),
                        )),
                  )
                ],
              ),
            ),
        ),);
  }
}
