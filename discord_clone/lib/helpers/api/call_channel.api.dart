import 'dart:convert';
import 'package:discord_clone/helpers/constains/api.constains.dart';
import 'package:discord_clone/models/api_response.model.dart';
import 'config/config.api.dart';

Future<ApiResponse> createCallChannel(
    String callChannelName, String serverId) async {
  final response = await ApiClient()
      .post(API_CALL_CHANNELS, {"name": callChannelName, "serverId": serverId});
  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
