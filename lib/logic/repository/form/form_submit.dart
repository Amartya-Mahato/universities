import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:universities/logic/repository/auth/auth_error.dart';

class FormSubmitRepo {
  static Future<void> submit(
      String email, String name, int age, Uint8List image) async {
    Reference reference = FirebaseStorage.instance.ref('images/IMG_$email');
    try {
      FirebaseStorage.instance
          .ref('images/IMG_$email')
          .delete()
          .onError((error, stackTrace) => throw Exception(error)).then((value) => null);
    } catch (e) {
      err = e.toString();
    }

    try {
      await reference.putData(image);
      String url = await reference.getDownloadURL();

      FirebaseFirestore.instance
          .collection('user')
          .doc(email)
          .set({'name': name, 'email': email, 'age': age, 'image': url});
    } catch (e) {
      throw Exception(e);
    }
  }
}
