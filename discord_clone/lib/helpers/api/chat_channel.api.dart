import 'dart:convert';
import 'package:discord_clone/helpers/constains/api.constains.dart';
import 'package:discord_clone/models/api_response.model.dart';
import 'config/config.api.dart';

Future<ApiResponse> createChatChannel(
    String chatChannelName, String serverId) async {
  final response = await ApiClient()
      .post(API_CHAT_CHANNELS, {"name": chatChannelName, "serverId": serverId});
  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
