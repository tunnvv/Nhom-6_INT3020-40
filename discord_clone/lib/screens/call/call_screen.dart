import 'package:discord_clone/screens/call/prepare_call.dart';
import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

const appId = 'f713d0d0559846158aab1a1b8f12db62';

class CallScreen extends StatefulWidget {
  final String channelName;
  final String token;
  final ClientRoleType role;
  const CallScreen(
      {Key? key,
      required this.channelName,
      required this.token,
      required this.role})
      : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    super.dispose();
  }

  Future<void> _initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add('APP_ID missing, please provide your APP_ID');
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(appId: appId));
    await _engine.enableVideo();
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    );

    _addAgoraEventHandlers();
    await _engine.joinChannel(
        token: widget.token,
        channelId: widget.channelName,
        uid: 0,
        options: options);
  }

  _addAgoraEventHandlers() {
    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (err, msg) {
        setState(() {
          final info = 'Error: $msg';
          _infoStrings.add(info);
        });
      },
      onJoinChannelSuccess: (connection, elapsed) {
        setState(() {
          final info = 'Join Channel: $connection';
          _infoStrings.add(info);
        });
      },
      onLeaveChannel: (connection, stats) {
        setState(() {
          _infoStrings.add('Leave Channel');
          _users.clear();
        });
      },
      // onUserJoined: (connection, uid, elapsed) {
      //   setState(() {
      //     final info = 'User Joined: $uid';
      //     _infoStrings.add(info);
      //     _users.add(uid);
      //   });
      // },
      // onUserOffline: (connection, uid, reason) {
      //   setState(() {
      //     final info = 'User Offline: $uid';
      //     _infoStrings.add(info);
      //     _users.remove(uid);
      //   });
      // },
      // onFirstRemoteVideoFrame: (connection, uid, width, height, elapsed) {
      //   setState(() {
      //     final info = 'First Remove Video: $uid ${width}x$height';
      //     _infoStrings.add(info);
      //   });
      // },
    ));
  }

  // Widget _viewRow() {
  //   final List<StatefulWidget> list = [];
  //   if (widget.role == ClientRoleType.Broadcaster) {
  //     list.add(rtc_local_view.SurfaceView());
  //   }
  //   for (var uid in _users) {
  //     list.add(rtc_remote_view.SurfaceView(
  //       uid: uid,
  //       channelId: widget.channelName,
  //     ));
  //   }
  //   final views = list;
  //   return Column(
  //     children: List.generate(
  //         views.length,
  //         (index) => Expanded(
  //               child: views[index],
  //             )),
  //   );
  // }

  Widget _toolBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            setState(() {
              muted = !muted;
            });
            _engine.muteLocalAudioStream(muted);
          },
          shape: const CircleBorder(),
          elevation: 2.0,
          padding: const EdgeInsets.all(12.0),
          fillColor: muted ? Colors.blueAccent : Colors.white,
          child: Icon(
            muted ? Icons.mic_off : Icons.mic,
            color: muted ? Colors.white : Colors.blueAccent,
            size: 20,
          ),
        ),
        RawMaterialButton(
          onPressed: () => Navigator.pop(context),
          shape: const CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.redAccent,
          padding: const EdgeInsets.all(15.0),
          child: const Icon(
            Icons.call_end,
            color: Colors.white,
            size: 35,
          ),
        ),
        RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            )),
      ]),
    );
  }

  Widget _panel() {
    return Visibility(
      visible: viewPanel,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: ListView.builder(
                  reverse: true,
                  itemCount: _infoStrings.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (_infoStrings.isEmpty) {
                      return const Text("null");
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                _infoStrings[index],
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Name'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (() {
                setState(() {
                  viewPanel = !viewPanel;
                });
              }),
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: <Widget>[
              _panel(),
              _toolBar(),
            ],
          ),
        ));
  }
  // @override
  // Widget build(BuildContext context) {
  //   BorderRadiusGeometry radius = const BorderRadius.only(
  //     topLeft: Radius.circular(15.0),
  //     topRight: Radius.circular(15.0),
  //   );
  //   return Scaffold(
  //     backgroundColor: Colors.white70,
  //     appBar: AppBar(
  //       backgroundColor: Colors.transparent,
  //       elevation: 0.0,
  //       leading: ElevatedButton(
  //         onPressed: () {},
  //         style: ElevatedButton.styleFrom(
  //             backgroundColor: kSigninBntColor, shape: const CircleBorder()),
  //         child: const Icon(
  //           Icons.expand_more,
  //           size: 26,
  //           color: Colors.white,
  //         ),
  //       ),
  //       title: const Text(
  //         "Name",
  //         selectionColor: Colors.black54,
  //         style: TextStyle(
  //             color: Colors.black12, fontWeight: FontWeight.bold, fontSize: 26),
  //       ),
  //       actions: <Widget>[
  //         ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //               backgroundColor: kSigninBntColor, shape: const CircleBorder()),
  //           child: const Icon(
  //             Icons.flip_camera_ios,
  //             size: 26,
  //             color: Colors.white,
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //               backgroundColor: kSigninBntColor, shape: const CircleBorder()),
  //           child: const Icon(
  //             Icons.person_add,
  //             size: 26,
  //             color: Colors.white,
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //               backgroundColor: kSigninBntColor, shape: const CircleBorder()),
  //           child: const Icon(
  //             Icons.chat_bubble,
  //             size: 26,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ],
  //     ),
  //     body: Stack(
  //       alignment: Alignment.center,
  //       children: <Widget>[
  //         const SizedBox(height: 800),
  //         Visibility(
  //           maintainState: true,
  //           maintainAnimation: true,
  //           visible: true,
  //           child: SlidingUpPanel(
  //             color: kSigninBntColor,
  //             controller: PanelController(),
  //             borderRadius: radius,
  //             panel: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: <Widget>[
  //                 const SizedBox(
  //                   height: 30,
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     ElevatedButton(
  //                       onPressed: () {},
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.white,
  //                           shape: const CircleBorder()),
  //                       child: const Icon(
  //                         Icons.videocam,
  //                         size: 36,
  //                         color: Colors.black87,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 35,
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {},
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: kSigninBntColor,
  //                           shape: const CircleBorder()),
  //                       child: const Icon(
  //                         Icons.mobile_screen_share,
  //                         size: 36,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 35,
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {},
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: kSigninBntColor,
  //                           shape: const CircleBorder()),
  //                       child: const Icon(
  //                         Icons.mic,
  //                         size: 36,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 35,
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {},
  //                       style: ElevatedButton.styleFrom(
  //                           minimumSize: const Size.square(50),
  //                           backgroundColor: Colors.red,
  //                           padding: const EdgeInsets.all(10),
  //                           shape: const CircleBorder()),
  //                       child: const Icon(
  //                         Icons.phone_disabled,
  //                         size: 36,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
