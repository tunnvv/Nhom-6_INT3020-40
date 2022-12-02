import 'package:discord_clone/screens/home/home_screen.dart';
import 'package:discord_clone/helpers/constains/colors.dart';
import 'package:flutter/material.dart';
import 'package:discord_clone/screens/welcome/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initalize hive
  await Hive.initFlutter();

  // open the box
  await Hive.openBox("storageBox");

  runApp(DiscordClone());
}

class DiscordClone extends StatelessWidget {
  DiscordClone({super.key});

  final _storageBox = Hive.box("storageBox");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Discord',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: _storageBox.get("accessToken") != null
          ? const WelcomeScreen()
          : const WelcomeScreen(),
    );
  }
}
