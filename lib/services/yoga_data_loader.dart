import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yoga_app/models/yoga_app_model.dart';

class YogaDataLoader {
  static Future<YogaAppModel> loadSession(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final jsonMap = json.decode(jsonString);
    return YogaAppModel.fromJson(jsonMap);
  }
}
