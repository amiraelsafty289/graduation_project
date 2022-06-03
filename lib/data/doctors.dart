import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String name;
  String age;
  String address;
  String governorate;
  String image;
  String degree;

  Doctor(
      {required this.name,
      required this.address,
      required this.age,
      required this.degree,
      required this.governorate,
      required this.image});

  Doctor.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'] as String,
          age: json['age'] as String,
          address: json['address'] as String,
    governorate: json['governorate'] as String,
          image: json['image'] as String,
          degree: json['degree'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'address': address,
      'governorate': governorate,
      'image': image,
      'degree': degree,
    };
  }
  static CollectionReference<Doctor> withConverter() {
    return FirebaseFirestore.instance
        .collection('doctors')
        .withConverter<Doctor>(
      fromFirestore: (snapshot, _) => Doctor.fromJson(snapshot.data()!),
      toFirestore: (doctor, _) => doctor.toJson(),
    );
  }
}
