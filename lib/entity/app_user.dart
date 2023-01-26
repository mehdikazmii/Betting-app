import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? id;
  String? username;
  String? profilePhotoPath;
  String bio = "";
  String? country;
  String? email;
  double wallet = 100;
  int level = 1;
  bool verified = false;
  bool refered = false;
  bool private = false;

  AppUser({
    required this.id,
    required this.username,
    required this.profilePhotoPath,
    required this.country,
    required this.email,
  });

  AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    username = snapshot['name'];
    email = snapshot['email'];
    profilePhotoPath = snapshot['profile_photo_path'];
    bio = snapshot.get('bio') ?? '';
    country = snapshot['country'];
    level = snapshot['level'];
    wallet = double.parse(snapshot['wallet'].toString());
    verified = snapshot['verified'];
    refered = snapshot['refered'];
    private = snapshot['private'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': username,
      'email': email,
      'profile_photo_path': profilePhotoPath,
      'bio': bio,
      'country': country,
      'wallet': wallet,
      'level': level,
      'verified': verified,
      'private': private,
      'refered': refered
    };
  }
}
