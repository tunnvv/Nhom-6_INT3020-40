import 'dart:convert';

import 'package:discord_clone/utils/constants/colors.dart';
import 'package:discord_clone/widgets/chat_item.dart';
import 'package:flutter/material.dart';

class Chat {
  final String avatar;
  final String name;
  final String message;
  final String createdAt;

  Chat(this.name, this.avatar, this.message, this.createdAt);

  Chat.fromJson(Map<String, dynamic> json)
      : avatar = json['avatar'],
        name = json['name'],
        message = json['message'],
        createdAt = json['createdAt'];
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatController = TextEditingController();

  List<Chat> chatList = (jsonDecode(
              '[{"name":"John","message":"Hello","avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","createdAt":"Hôm nay"},{"name":"John","message":"Hello","avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","createdAt":"Hôm nay"}]')
          as List)
      .map((item) => Chat.fromJson(item))
      .toList();

  @override
  void dispose() {
    super.dispose();
    chatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        color: primaryTextColor,
                        size: 30,
                      ),
                      Text(
                        "#kênh-công-chúa",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryTextColor),
                      ),
                      Icon(
                        Icons.person_add_alt_1,
                        color: primaryTextColor,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
                Container(
                    color: backgroundColor,
                    height: screenSize.height - 150,
                    width: screenSize.width,
                    child: ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        itemCount: chatList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ChatItemWidget(
                              avatar: chatList[index].avatar,
                              name: chatList[index].name,
                              message: chatList[index].message,
                              createdAt: chatList[index].createdAt);
                        })),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: const TextStyle(color: primaryTextColor),
                  controller: chatController,
                  decoration: InputDecoration(
                    hintText: "Nhắn #kênh-công-chúa",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.black,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (chatController.text != "") {
                          Map<String, dynamic> chatItemJson = {
                            "name": "John",
                            "message": chatController.text,
                            "avatar":
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU",
                            "createdAt": "Hôm nay"
                          };
                          chatController.clear();
                          setState(() {
                            chatList.add(Chat.fromJson(chatItemJson));
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
