import 'package:discord_clone/screens/chat_screen.dart';
import 'package:discord_clone/screens/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:discord_clone/utils/colors.dart';
import 'package:discord_clone/screens/icons/my_flutter_app_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Channel> kenh_chat = [
    Channel(Icon(MyFlutterApp.hashtag), "kênh-công-chúa"),
  ];

  List<Channel> kenh_dam_thoai = [Channel(Icon(Icons.volume_up), "Chung")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
          child: SingleChildScrollView(
        child: Container(
            child: Row(
          children: [
            Expanded(
              child: My_sever(),
            ),
            Expanded(
              flex: 3,
              child: Channel_of_sever(context),
            )
          ],
        )),
      )),
    );
  }
}

Widget My_sever() {
  return Container(
    padding: EdgeInsets.only(top: 15),
    child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      IconButton(
        icon: Image.asset("assets/images/discord.png"),
        iconSize: 40,
        onPressed: () {},
      ),
      IconButton(
        icon: Image.asset("assets/images/discord.png"),
        iconSize: 40,
        onPressed: () {},
      )
    ]),
  );
}

Widget Channel_of_sever(BuildContext context) {
  return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text("HadesGuild", style: TextStyle(color: Colors.grey, fontSize: 16)),
        // ExpansionTile(
        //   title: Text("KÊNH CHAT"),
        //   children: <Widget>[
        //     Padding(
        //       padding: EdgeInsets.only(left: 15),
        //       child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             TextButton(
        //                 onPressed: () {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => ChatScreen()));
        //                 },
        //                 child: Text("#kênh-công-chúa"))
        //           ]),
        //     )
        //   ],
        // ),
        // ExpansionTile(
        //   title: Text("KÊNH ĐÀM THOẠI"),
        //   children: <Widget>[
        //     Padding(
        //       padding: EdgeInsets.only(left: 15),
        //       child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             TextButton.icon(
        //                 onPressed: () {},
        //                 icon: Icon(Icons.volume_up),
        //                 label: Text("Chung"))
        //           ]),
        //     )
        //   ],
        // ),

        ExpansionPanelList()
      ]));
}

class Channel {
  Icon icon;
  String name;

  Channel(this.icon, this.name);
}
