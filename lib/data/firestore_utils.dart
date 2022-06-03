import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blood_bank_app/data/user.dart';


Future<void> addUserToFireStore(User user) {
  return User.withConverter().doc(user.id).set(user);
}

Future<User?> getUserById(String id) async {
  DocumentSnapshot<User> result = await User.withConverter().doc(id).get();
  return result.data();
}
