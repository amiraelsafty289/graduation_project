import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/data/doctors.dart';
import 'package:flutter_blood_bank_app/doctors/doctor_details.dart';

class DoctorItem extends StatelessWidget {
  Doctor doctor ;
  DoctorItem(this.doctor);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(DoctorDetailsScreen.ROUTE_NAEM,arguments: doctor);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18 , vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network('${doctor.image}',
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            Column(
              children: [
                Text(doctor.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black
                  ),
                ),
                SizedBox(height: 10,),
                Text(doctor.address,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
