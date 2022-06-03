import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/bottom_sheet/star_rating.dart';
import 'package:flutter_blood_bank_app/provider/auth_provider.dart';
import 'package:flutter_blood_bank_app/utils.dart';
import 'package:provider/provider.dart';

enum PromptType { rate }

double roundedCornerRadius = 24;

class EndEpisodeBottomSheet extends StatefulWidget {
  @override
  _EndEpisodeBottomSheetState createState() => _EndEpisodeBottomSheetState();
}

class _EndEpisodeBottomSheetState extends State<EndEpisodeBottomSheet> {
  PromptType type = PromptType.rate;

  @override
  void initState() {
    super.initState();
  }

  void nextPrompt() {
    setState(() {
      type = PromptType.rate;
    });
  }

  Widget getChild() {
    return buildRatingBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400), child: getChild()));
  }
}

late AuthProvider provider;
Widget buildRatingBottomSheet(BuildContext context) {
  provider = Provider.of<AuthProvider>(context);
  double rating = 0;
  return Wrap(
    alignment: WrapAlignment.center,
    children: [
      StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rate Us',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(
                height: 24,
              ),
              StarRating(
                rating: rating,
                callback: (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                },
                size: 56,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                child: const Text('Done'),
                onPressed: rating > 0
                    ? () {
                        submitRate(rating , context);
                      }
                    : () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: rating > 0 ? Colors.blue : Colors.grey,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    ],
  );
}

void submitRate(double rate , BuildContext context) {
  CollectionReference ratesRef = FirebaseFirestore.instance.collection('rates');
  ratesRef.doc().set({
    'userId': provider.user!.id,
    'userName': provider.user!.userName,
    'rate': rate
  }).then((value){
    Navigator.pop(context);
  });
}
