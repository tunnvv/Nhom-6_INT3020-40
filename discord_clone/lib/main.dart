import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:discord_clone/screens/welcome/welcome_screen.dart';

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
      title: 'Welcome Discord',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home: WelcomeScreen(),
    );
  }
}
