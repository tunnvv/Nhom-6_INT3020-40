import 'package:discord_clone/helpers/api/servers.api.dart';
import 'package:discord_clone/helpers/api/users.api.dart';
import 'package:discord_clone/helpers/constains/colors.dart';
import 'package:discord_clone/helpers/fake_avatar.dart';
import 'package:discord_clone/models/api_response.model.dart';
import 'package:discord_clone/models/user.model.dart';
import 'package:discord_clone/widgets/channel_item.dart';
import 'package:discord_clone/widgets/group_channel_title.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  TextEditingController nameController = TextEditingController();
  late Future<User> me;

  @override
  void initState() {
    super.initState();
    me = getMyInfo();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
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
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.servers.length + 1,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: index != snapshot.data?.servers.length
                                      ? GestureDetector(
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                channelBackgroundColor,
                                            backgroundImage: NetworkImage(
                                              getAvatar(),
                                            ),
                                          ),
                                        )
                                      : RawMaterialButton(
                                          fillColor: channelBackgroundColor,
                                          elevation: 0,
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(12.0),
                                          onPressed: () {
                                            showModalBottomSheet<dynamic>(
                                              isScrollControlled: true,
                                              context: context,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.6,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: const BoxDecoration(
                                                      color:
                                                          bottomSheetBackgroundColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(
                                                                      8))),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        "Tạo Máy Chủ Của Bạn",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      const Text(
                                                        "Máy chủ của bạn là nơi bạn giao lưu với bạn bè của mình. Hãy tạo máy chủ của riêng bạn và bắt đầu trò chuyện.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              welcomeSecondaryColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: TextField(
                                                          controller:
                                                              nameController,
                                                          cursorColor:
                                                              cursorColor,
                                                          style: const TextStyle(
                                                              color:
                                                                  whiteColor),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Nhập Tên Máy Chủ",
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color:
                                                                        bottomSheetTextSecondaryColor,
                                                                    fontSize:
                                                                        14),
                                                            filled: true,
                                                            fillColor:
                                                                bottomSheetBackgroundWidgetColor,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12.0,
                                                                    vertical:
                                                                        4.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              borderSide:
                                                                  const BorderSide(
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          minimumSize: const Size
                                                              .fromHeight(42),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              welcomeRegisterButtonColor,
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                        ),
                                                        onPressed: () async {
                                                          final String name =
                                                              nameController
                                                                  .text;
                                                          ApiResponse
                                                              apiResponse =
                                                              await createServer(
                                                                  name);

                                                          if (apiResponse
                                                              .isSuccess) {
                                                            () => Navigator.pop(
                                                                context);

                                                            Fluttertoast
                                                                .showToast(
                                                              msg: apiResponse
                                                                  .payload
                                                                  .message,
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  signinLoginButtonColor,
                                                              textColor:
                                                                  whiteColor,
                                                            );
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Tạo Máy Chủ'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(42),
                                padding: EdgeInsets.zero,
                                backgroundColor: welcomeLoginButtonColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.person_add,
                                    color: channelIconColor,
                                  ),
                                  Text('Lời mời'),
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

            return const Center(
                child: CircularProgressIndicator(
              color: welcomeRegisterButtonColor,
            ));
          },
        ),
      ),
    );
  }
}
