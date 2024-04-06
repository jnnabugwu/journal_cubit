import 'package:firebase_auth/firebase_auth.dart';

///what problem am i trying to solve here
///what does the user model contain
///email, name, uid

class UserModel {
  final String email;
  final String name;
  final String uid;

  const UserModel({required this.email, required this.name, required this.uid});

  //create the to map method

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'name': name};
  }

  //create the from Json function. Take in a json and turn it into an object

  UserModel.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        name = json['name'] as String,
        uid = json['uid'] as String;
}
