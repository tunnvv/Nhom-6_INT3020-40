import 'package:flutter/material.dart';
import 'package:discord_clone/screens/signin/signin_screen.dart';
import 'package:discord_clone/utils/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 65.0,
            left: 75.0,
            right: 70.0,
            child: Image.asset(
              "assets/images/discord_logo.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 155.0,
            left: 55.0,
            right: 50.0,
            child: Image.asset(
              "assets/images/discord_characters.png",
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
              top: 455.0,
              left: 35.0,
              right: 30.0,
              child: Text(
                "Chào mừng bạn đến với Discord",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const Positioned(
            top: 540.0,
            left: 35.0,
            right: 30.0,
            child: Text(
              "Tham gia cùng hơn 100 triệu người dùng Discord và trò chuyện với bạn bè và các cộng đồng khác nhau.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            top: 640.0,
            left: 20.0,
            right: 16.0,
            child: SizedBox(
              height: 42.0,
              width: 130,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kSignupBntColor),
                ),
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(
                      color: kPrimaryLightColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            top: 690.0,
            left: 20.0,
            right: 16.0,
            child: SizedBox(
              height: 42.0,
              width: 130,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SigninScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kSigninBntColor),
                ),
                child: const Text(
                  "Đăng nhập",
                  style: TextStyle(
                      color: kPrimaryLightColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
