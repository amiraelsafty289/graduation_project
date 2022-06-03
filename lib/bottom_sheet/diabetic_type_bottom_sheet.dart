import 'package:flutter/material.dart';

class DiabeticTypeBottomSheet extends StatefulWidget {
  String diabeticType ;
  Function (String) onDiabeticTypeChanged ;
  DiabeticTypeBottomSheet({required this.diabeticType , required this.onDiabeticTypeChanged});

  @override
  State<DiabeticTypeBottomSheet> createState() => _DiabeticTypeBottomSheetState();
}

class _DiabeticTypeBottomSheetState extends State<DiabeticTypeBottomSheet> {
  List<String> daibetics = [
    'diabetic1',
    'diabetic2',
    'diabetic3',
    'diabetic4',
    'diabetic5',
    'diabetic6',
    'diabetic7',
    'diabetic8',
    'diabetic9',
    'diabetic10',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: ListView.builder(
          itemCount: daibetics.length,
          itemBuilder: (context , index){
            bool selected = widget.diabeticType == daibetics[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){widget.onDiabeticTypeChanged( daibetics[index]); setState(() {
                  widget.diabeticType=  daibetics[index];
                  Navigator.pop(context);
                });},
                child: Row(
                  children: [
                    selected ? Icon(Icons.check_sharp, color: Colors.blue,) : Container(),
                    Spacer(),
                    Text(daibetics[index], style: TextStyle(fontSize: 18, fontWeight: selected? FontWeight.bold: FontWeight.w400, color: selected? Colors.blue : Colors.black),),

                  ],
                ),
              ),
            );
          }),
    );
  }
}
