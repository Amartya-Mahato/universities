import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardRepo {
  static Future<List<String>> initialize() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? email = pref.getString('email');

    if (email != null) {
      var snapshot =
          await FirebaseFirestore.instance.collection('user').doc(email).get();
      String name = snapshot.data()!['name'];
      String age = '${snapshot.data()!['age']}';
      String imageURl = snapshot.data()!['image'];
      return [name, age, imageURl];
    } else {
      throw Exception('Email is not present in the memory');
    }
  }
}
