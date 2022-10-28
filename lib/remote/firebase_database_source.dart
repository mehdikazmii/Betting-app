import 'package:cloud_firestore/cloud_firestore.dart';
import '../entity/app_user.dart';

class FirebaseDatabaseSource {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  void addUser(AppUser user) {
    instance.collection('users').doc(user.id).set(user.toMap());
  }

  void updateUser(AppUser user) async {
    instance.collection('users').doc(user.id).update(user.toMap());
  }

  Future<DocumentSnapshot> getUser(String? userId) {
    return instance.collection('users').doc(userId).get();
  }

  Future<DocumentSnapshot> getSwipe(String? userId, String? swipeId) {
    return instance
        .collection('users')
        .doc(userId)
        .collection('swipes')
        .doc(swipeId)
        .get();
  }
}
