import 'package:discord_clone/screens/chat_screen.dart';
import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DiscordClone());
}

class DiscordClone extends StatelessWidget {
  const DiscordClone({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: backgroundColor),
        title: 'Discord Clone',
        home: const ChatScreen());
  }
}
