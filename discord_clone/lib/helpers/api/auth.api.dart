import 'dart:convert';
import 'package:discord_clone/helpers/constains/api.constains.dart';
import 'package:discord_clone/models/auth.model.dart';
import 'package:hive/hive.dart';
import 'config/config.api.dart';

final _storageBox = Hive.box("storageBox");

Future<Auth> login(String email, String password) async {
  final response = await ApiClient()
      .post(API_AUTH_LOGIN, {"email": email, "password": password});

  if (response.statusCode == 200 || response.statusCode == 201) {
    Auth auth = Auth.fromJson(jsonDecode(response.body));
    _storageBox.put("accessToken", auth.accessToken);
    return auth;
  } else {
    return const Auth();
  }
}
