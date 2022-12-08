import 'dart:convert';

import 'package:http/http.dart';
import 'package:universities/logic/model/university_api_model.dart';
import 'package:http/http.dart' as http;

class UniversityApiRepo {
  static Future<List<UniversityApiModel>> loadUniversityApiModel() async {
    try {
      String uri = 'http://universities.hipolabs.com/search?country=India';
      Uri url = Uri.parse(uri);
      Response response = await http.get(url);
      var result = json.decode(response.body);
      List<UniversityApiModel> list = [];
      for (var value in result) {
        UniversityApiModel model = UniversityApiModel.fromJson(value);
        list.add(model);
      }
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }
}
