import 'package:discord_clone/helpers/api/users.api.dart';
import 'package:discord_clone/helpers/constains/colors.dart';
import 'package:discord_clone/models/user.model.dart';
import 'package:discord_clone/widgets/channel_item.dart';
import 'package:discord_clone/widgets/group_channel_title.dart';
import 'package:flutter/material.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  late Future<User> me;

  @override
  void initState() {
    super.initState();
    dynamic tmp = getMyInfo();
    if (tmp is Future<User>) {
      me = tmp;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width - 58,
      color: statusBarColor,
      child: SafeArea(
        child: FutureBuilder<User>(
          future: me,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  SizedBox(
                    width: 72,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.servers.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: index != 10 - 1
                                      ? GestureDetector(
                                          child: const CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                channelBackgroundColor,
                                            backgroundImage: AssetImage(
                                              "assets/images/avatar.jpg",
                                            ),
                                          ),
                                        )
                                      : RawMaterialButton(
                                          fillColor: channelBackgroundColor,
                                          elevation: 0,
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(12.0),
                                          onPressed: () {},
                                          child: const Icon(
                                            Icons.add,
                                            color: channelIconAddColor,
                                          )),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        color: channelBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 20),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                      "J2Team",
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Icon(
                                    Icons.more_horiz,
                                    color: channelIconColor,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: 2,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Theme(
                                      data: ThemeData().copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        backgroundColor: channelBackgroundColor,
                                        title: const GroupChannelTitleWidget(
                                            name: "KÊNH CHAT"),
                                        onExpansionChanged: (value) {},
                                        tilePadding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        trailing: const Icon(
                                          Icons.add,
                                          color: channelIconColor,
                                          size: 20,
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        children: <Widget>[
                                          ChannelItemWidget(
                                              key: Key(
                                                  'expansionTileChannel$index'),
                                              type: ChannelItemType.chat,
                                              name: "chung"),
                                          ChannelItemWidget(
                                              key: Key(
                                                  'expansionTileCall$index'),
                                              type: ChannelItemType.callVideo,
                                              name: "Phòng chờ")
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
