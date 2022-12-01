import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:discord_clone/screens/welcome/welcome_screen.dart';

void main() {
  runApp(const DiscordClone());
}

class DiscordClone extends StatelessWidget {
  const DiscordClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Discord',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      builder: (_, child) => _Unfocus(
        child: child!,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class _Unfocus extends StatelessWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
