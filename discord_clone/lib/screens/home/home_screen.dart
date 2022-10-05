import 'package:discord_clone/screens/chat/chat_screen.dart';
import 'package:discord_clone/screens/icons/my_flutter_app_icons.dart';
import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ChatScreen(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
    Text(
      'Index 4: Account',
      style: optionStyle,
    ),
  ];
  List<PanelList> _panels = [
    PanelList(1, "KÊNH CHAT", false),
    PanelList(2, "KÊNH ĐÀM THOẠI", false),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
            ),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: bottomNavigationColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: unSelectedIconColor,
          selectedItemColor: whiteColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/discord_icon_unselected.png",
                height: 24,
                width: 24,
              ),
              label: 'Home',
              activeIcon: Image.asset(
                "assets/images/discord_icon.png",
                height: 24,
                width: 24,
              ),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Friends',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.alternate_email),
              label: 'Notifications',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
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

class PanelList {
  int index;
  String name;
  bool isExpanded;

  PanelList(this.index, this.name, this.isExpanded);
}
