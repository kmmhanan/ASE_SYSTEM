import 'package:firebase_database/firebase_database.dart';

enum User {
  driver,
  passenger,
}

class UserModel {
  String? name;
  String? id;
  String? contactNum;
  String? email;
  bool? blockStatus;

  UserModel({this.name, this.id, this.contactNum, this.email, this.blockStatus});

  UserModel.fromSnapshot(DataSnapshot snap) {
    name = (snap.value as dynamic)["name"];
    id = snap.key;
    contactNum = (snap.value as dynamic)["contactNum"];
    email = (snap.value as dynamic)["email"];
    blockStatus = (snap.value as dynamic)["blockStatus"];
  }
}
