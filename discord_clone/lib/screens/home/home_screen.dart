import 'package:discord_clone/screens/chat/chat_screen.dart';
import 'package:discord_clone/screens/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:discord_clone/utils/constants/colors.dart';
import 'package:discord_clone/screens/icons/my_flutter_app_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<PanelList> _panels = [
    PanelList(1, "KÊNH CHAT", false),
    PanelList(2, "KÊNH ĐÀM THOẠI", false),
  ];
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
              child: ExpansionPanelList(
                expansionCallback: (_panelsIndex, isExpanded) {
                  setState(() {
                    _panels[_panelsIndex].isExpanded = !isExpanded;
                  });
                },
                children: _panels.map((_panel) {
                  return ExpansionPanel(
                      isExpanded: _panel.isExpanded,
                      headerBuilder: (bc, status) {
                        return Container(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(_panel.name)));
                      },
                      body: Container(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Icon(MyFlutterApp.hashtag, size: 15),
                          title: Text("chung"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen()));
                          },
                        ),
                      ));
                }).toList(),
              ),
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

// Widget Channel_of_sever(BuildContext context) {
//   List<PanelList> _panels = [
//     PanelList(1, "KÊNH CHAT"),
//     PanelList(2, "KÊNH ĐÀM THOẠI")
//   ];
//   return Container(
//       // padding: EdgeInsets.only(top: 15),
//       // child: Column(
//       //   mainAxisAlignment: MainAxisAlignment.start,
//       //   children: [
//       //     Text("HadesGuild",
//       //         style: TextStyle(color: Colors.grey, fontSize: 16)),
//       //     // ExpansionTile(
//       //     //   title: Text("KÊNH CHAT"),
//       //     //   children: <Widget>[
//       //     //     ListTile(
//       //     //       leading: Icon(MyFlutterApp.hashtag, size: 15),
//       //     //       title: Text("chung"),
//       //     //       onTap: () {
//       //     //         Navigator.push(context,
//       //     //             MaterialPageRoute(builder: (context) => ChatScreen()));
//       //     //       },
//       //     //     ),
//       //     //     ListTile(
//       //     //       leading: Icon(MyFlutterApp.hashtag, size: 15),
//       //     //       title: Text("kênh-công-chúa"),
//       //     //       onTap: () {
//       //     //         Navigator.push(context,
//       //     //             MaterialPageRoute(builder: (context) => ChatScreen()));
//       //     //       },
//       //     //     )
//       //     //   ],
//       //     // ),
//       //     // ExpansionTile(title: Text("KÊNH ĐÀM THOẠI"), children: <Widget>[
//       //     //   ListTile(
//       //     //     leading: Icon(Icons.volume_up, size: 15),
//       //     //     title: Text("Chung"),
//       //     //     onTap: () {},
//       //     //   )
//       //     // ])

//       //     ExpansionPanelList(
//       //       children: [
//       //         ExpansionPanel(
//       //             headerBuilder: ((context, isExpanded) {
//       //               return ListTile(title: Text("KÊNH CHAT"));
//       //             }),
//       //             body: ListTile(title: Text("Chung")))
//       //       ],
//       //       expansionCallback: ((panelIndex, isExpanded) {
//       //         setState(() {});
//       //       }),
//       //     )
//       //   ],
//       // )
//       child: ExpansionPanelList(
//         children:
//       )
//   );
// }

class PanelList {
  int index;
  String name;
  bool isExpanded;

  PanelList(this.index, this.name, this.isExpanded);
}
