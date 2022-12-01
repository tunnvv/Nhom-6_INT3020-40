import 'package:discord_clone/screens/call/call_screen.dart';
import 'package:discord_clone/screens/channel/channel_screen.dart';
import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:math';

import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

const channelName = ['call0', 'call1', 'call2', 'call3', 'call4', 'call5'];
const token = [
  '007eJxTYPi36Z9Li/Wqr8mu0mJf7Jwk+56HX+goqftyYdnWPes6+TcrMKSZGxqnGKQYmJpaWpiYGZpaJCYmGSYaJlmkGRqlJJkZBb3qSG4IZGRYuKWdhZEBAkF8VobkxJwcAwYGABKCIeU=',
  '007eJxTYKhoXnD7xzyTmfVhC/aIiCzNau04HFjcOvPphWDn2XNkFk9RYEgzNzROMUgxMDW1tDAxMzS1SExMMkw0TLJIMzRKSTIzUs7qSG4IZGRQYpnEwsgAgSA+K0NyYk6OIQMDAKIuHzs=',
  '007eJxTYJjhwPm2wEXn8eKw2/rS5wMvT9UN+Ns29Z1WSMVGWbPpH/sUGNLMDY1TDFIMTE0tLUzMDE0tEhOTDBMNkyzSDI1SksyMujM7khsCGRnqyiuYGBkgEMRnZUhOzMkxYmAAAF8HH1g=',
  '007eJxTYFj6tsdVNcOJM9r/73epFN6COVNqtypUf0r8quAfXSxx+pcCQ5q5oXGKQYqBqamlhYmZoalFYmKSYaJhkkWaoVFKkpnRmayO5IZARgbvNQyMjAwQCOKzMiQn5uQYMzAAACvAHo0=',
  '007eJxTYNDcVfG1vninsOr+wiPMuXeuShYxLLEw37aH//HyZ3v1wzcpMKSZGxqnGKQYmJpaWpiYGZpaJCYmGSYaJlmkGRqlJJkZvcrqSG4IZGRgPviOhZEBAkF8VobkxJwcEwYGAHV+IAM=',
  '007eJxTYDhs0bv3ulJ9+KT99c1Hr0wySz3aZpU25dPC5kc2P55Pay1QYEgzNzROMUgxMDW1tDAxMzS1SExMMkw0TLJIMzRKSTIzYsvuSG4IZGQ4LubMwAiFID4rQ3JiTo4pAwMAF8YhCQ=='
];
Random rand = Random();
int index = 0;

class PrepareCallScreen extends StatefulWidget {
  const PrepareCallScreen({Key? key}) : super(key: key);

  @override
  State<PrepareCallScreen> createState() => _PrepareCallScreenState();
}

class _PrepareCallScreenState extends State<PrepareCallScreen> {
  final _channelName = channelName[index];
  final _token = token[index];
  final ClientRoleType _role = ClientRoleType.clientRoleBroadcaster;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    );
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(ChannelScreenPageRoute());
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: kSigninBntColor, shape: const CircleBorder()),
          child: const Icon(
            Icons.expand_more,
            size: 26,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: const <Widget>[
            Icon(
              Icons.volume_up,
              color: kPrimaryLightColor,
            ),
            Text(
              " Chat",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kPrimaryLightColor),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: kSigninBntColor, shape: const CircleBorder()),
            child: const Icon(
              Icons.person_add,
              size: 26,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: kSigninBntColor, shape: const CircleBorder()),
            child: const Icon(
              Icons.chat_bubble,
              size: 26,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 190,
            left: 70,
            right: 65,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: kSigninBntColor,
                  shape: const CircleBorder()),
              child: const Icon(
                Icons.volume_up,
                size: 58,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            top: 250,
            left: 50,
            right: 50,
            child: Text(
              "Chưa có ai ở đây cả",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryLightColor),
            ),
          ),
          const Positioned(
            top: 300,
            left: 70,
            right: 65,
            child: Text(
              "Kênh thoại là để tán gẫu. Khi bạn đã sẵn sàng trò chuyện, chỉ cần nhảy vào tham gia. Bạn bè cũng có thể thấy và tham gia cùng bạn. Giống như sử dụng thần giao cách cảm để chào hỏi vậy.",
              textAlign: TextAlign.center,
              style: TextStyle(color: kPrimaryLightColor),
            ),
          ),
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: true,
            child: SlidingUpPanel(
              color: kSigninBntColor,
              controller: PanelController(),
              borderRadius: radius,
              panel: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey),
                        child: const Icon(Icons.mic, size: 36),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onJoin();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.green),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Tham gia'),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.volume_up,
                              size: 40.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallScreen(
          channelName: _channelName,
          token: _token,
          role: _role,
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    await permission.request();
    // log(status.toString());
  }
}

class ChannelScreenPageRoute extends PageRouteBuilder {
  ChannelScreenPageRoute()
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                const PrepareCallScreen());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(.0, .0), end: const Offset(0, 1))
              .animate(controller!),
      child: const ChannelScreen(),
    );
  }
}
