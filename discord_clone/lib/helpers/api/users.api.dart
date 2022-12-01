import 'dart:convert';
import 'package:discord_clone/helpers/constains/api.constains.dart';
import 'package:discord_clone/models/auth.model.dart';
import 'package:discord_clone/models/user.model.dart';
import 'package:hive/hive.dart';
import 'config/config.api.dart';

final _storageBox = Hive.box("storageBox");

Future<dynamic> getMyInfo() async {
  final response = await ApiClient()
      .get(API_USERS_ME);

  if (response.statusCode == 200 || response.statusCode == 201) {
    User user = User.fromJson(jsonDecode(response.body));

    return user;
  } else {
    return null;
  }
}
