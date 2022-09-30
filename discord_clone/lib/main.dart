import 'package:discord_clone/screens/secondPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'title',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.black,
        child: Row(children: [
          Column(children: [
            // InkWell(
            //   onTap: () {},
            //   child: Ink.image(
            //     image: AssetImage("C:\Users\hp\Desktop\discord.jpg"),
            //     height: 200,
            //     width: 200,
            //     fit: BoxFit.cover,
            //   ),
            IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/discord.jpg"),
              iconSize: 50,
            ),

            IconButton(onPressed: () {}, icon: Icon(Icons.messenger))
          ]),
          Column(children: [
            ButtonBar(children: [
              TextButton(
                  child: Text("general",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecondScreen()));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size.fromWidth(150))),
            ])
          ])
        ]),
      ),
    );
  }
}
