import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? id;
  String? username;
  String? profilePhotoPath;
  String bio = "";
  String? city;
  String? email;

  AppUser(
      {required this.id,
      required this.username,
      required this.profilePhotoPath,
      required this.city,
      required this.email});

  AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    username = snapshot['name'];
    email = snapshot['email'];
    profilePhotoPath = snapshot['profile_photo_path'];
    bio = snapshot.get('bio') ?? '';
    city = snapshot['city'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': username,
      'email': email,
      'profile_photo_path': profilePhotoPath,
      'bio': bio,
      'city': city
    };
  }
}
