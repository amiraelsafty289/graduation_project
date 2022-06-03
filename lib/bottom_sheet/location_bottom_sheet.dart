import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationBottomSheet extends StatefulWidget {
  String location;
  Function(String) onLocationChanged;
  LocationBottomSheet(
      {required this.location, required this.onLocationChanged});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  List<String> provinces = [
    'محافظة القاهرة',
    'الجيزة',
    'الأسكندرية'
        'الدقهلية',
    'الشرقية',
    'المنوفية',
    'القليوبية',
    'البحيرة',
    'الغربية',
    'بور سعيد.'
        'دمياط',
    'الإسماعلية',
    'السويس',
    'كفر الشيخ',
    'الفيوم',
    'بني سويف',
    'مطروح',
    'شمال سيناء',
    'جنوب سيناء',
    'المنيا',
    'أسيوط',
    'سوهاج',
    'قنا',
    'البحر الأحمر',
    'الأقصر',
    'أسوان',
    'الواحات',
    'الوادي الجديد'
  ];

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(12),
      child: ListView.builder(
        itemCount: provinces.length,
          itemBuilder: (context , index){
            bool selected = widget.location == provinces[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){widget.onLocationChanged( provinces[index]); setState(() {
              widget.location=  provinces[index];
              Navigator.pop(context);
            });},
            child: Row(
              children: [
                selected ? Icon(Icons.check_sharp, color: Colors.blue,) : Container(),
                Spacer(),
                Text(provinces[index], style: TextStyle(fontSize: 18, fontWeight: selected? FontWeight.bold: FontWeight.w400, color: selected? Colors.blue : Colors.black),),

              ],
            ),
          ),
        );
      }),
    );
  }
}
