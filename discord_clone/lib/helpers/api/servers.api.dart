import 'dart:convert';
import 'package:discord_clone/helpers/constains/api.constains.dart';
import 'package:discord_clone/models/api_response.model.dart';
import 'config/config.api.dart';

Future<ApiResponse> createServer(String serverName) async {
  final response = await ApiClient().post(API_SERVERS, {"name": serverName});
  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
