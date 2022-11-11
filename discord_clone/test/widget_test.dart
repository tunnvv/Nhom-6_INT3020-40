import 'package:discord_clone/screens/account/account_screen.dart';
import 'package:discord_clone/screens/call/call_screen.dart';
import 'package:discord_clone/screens/call/prepare_call.dart';
import 'package:discord_clone/screens/chat/chat_screen.dart';
import 'package:discord_clone/screens/friend/friend_screen.dart';
import 'package:discord_clone/screens/home/home_screen.dart';
import 'package:discord_clone/screens/signin/signin_screen.dart';
import 'package:discord_clone/screens/welcome/welcome_screen.dart';
import 'package:discord_clone/screens/channel/channel_screen.dart';
import 'package:discord_clone/utils/colors.dart';
import 'package:discord_clone/widgets/channel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestDiscordClone {
  static void run() {
    testWidgets('log in button test', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const WelcomeScreen(),
          navigatorObservers: [mockObserver],
        ),
      );
      final finder = find.widgetWithText(ElevatedButton, 'Đăng nhập');
      final widget = tester.firstWidget(finder) as ElevatedButton;
      final states = <MaterialState>{};
      final bgColor = widget.style?.backgroundColor?.resolve(states);
      expect(bgColor, welcomeLoginButtonColor);
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.byType(SigninScreen), findsOneWidget);
      expect(find.text('Chào mừng trở lại!'), findsOneWidget);
    });

    testWidgets('log in to app test', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const SigninScreen(),
          navigatorObservers: [mockObserver],
        ),
      );
      final textfield1 =
          find.widgetWithText(TextField, 'Email hoặc Số Điện Thoại');
      await tester.enterText(textfield1, 'admin');
      final textfield2 = find.widgetWithText(TextField, 'Mật khẩu');
      await tester.enterText(textfield2, '1234');
      final finder = find.widgetWithText(ElevatedButton, 'Đăng nhập');
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Friends'), findsOneWidget);
    });

    testWidgets('fill text on chat field', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const HomeScreen(),
          navigatorObservers: [mockObserver],
        ),
      );
      final textfield = find.byType(TextField);
      await tester.enterText(textfield, 'hi!');
      final sendButton = find.widgetWithIcon(IconButton, Icons.send);
      await tester.tap(sendButton);
      await tester.pump();
      expect(find.text('hi!'), findsOneWidget);

      // final listChannelButton = find.widgetWithIcon(IconButton, Icons.menu);
      // await tester.tap(listChannelButton);
      // await tester.pumpAndSettle();
      // expect(find.byType(ChannelScreen), findsOneWidget);
      // expect(find.text('KÊNH CHAT'), findsOneWidget);
    });

    // testWidgets('drag screen to open channel screen test',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     const MaterialApp(
    //       home: HomeScreen(),
    //     ),
    //   );
    //   final messageItem = find.text('Hello');
    //   await tester.drag(messageItem, const Offset(300.0, 0.0));
    //   await tester.pumpAndSettle();
    //   expect(find.text('J2Team'), findsOneWidget);
    // });

    // testWidgets('friend icon test', (WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: const ChannelScreen(),
    //       navigatorObservers: [mockObserver],
    //     ),
    //   );
    //   final friendIcon =
    //       find.widgetWithIcon(BottomNavigationBarItem, Icons.people);
    //   await tester.tap(friendIcon);
    //   await tester.pumpAndSettle();
    //   expect(find.byType(FriendScreen), findsOneWidget);
    //   expect(find.text('Bạn bè'), findsOneWidget);
    // });

    // testWidgets('account icon test', (WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: const ChannelScreen(),
    //       navigatorObservers: [mockObserver],
    //     ),
    //   );
    //   final accountIcon =
    //       find.widgetWithIcon(BottomNavigationBarItem, Icons.emoji_emotions);
    //   await tester.tap(accountIcon);
    //   await tester.pumpAndSettle();
    //   expect(find.byType(AccountScreen), findsOneWidget);
    //   expect(find.text('Tài khoản'), findsOneWidget);
    // });

    // testWidgets('chat channel test', (WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: const ChannelScreen(),
    //       navigatorObservers: [mockObserver],
    //     ),
    //   );
    //   final channelList = find.widgetWithText(ExpansionTile, 'KÊNH CHAT');
    //   await tester.tap(channelList);
    //   await tester.pump();

    //   final chatChannel = find.widgetWithText(ChannelItemWidget, 'chung');
    //   await tester.tap(chatChannel);
    //   await tester.pumpAndSettle();
    //   expect(find.byType(ChatScreen), findsOneWidget);
    //   expect(find.text('#kênh-công-chúa'), findsOneWidget);
    // });

    // testWidgets('call channel test', (WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: const ChannelScreen(),
    //       navigatorObservers: [mockObserver],
    //     ),
    //   );
    //   final channelList = find.widgetWithText(ExpansionTile, 'KÊNH CHAT');
    //   await tester.tap(channelList);
    //   await tester.pump();

    //   final callChannel = find.widgetWithText(ChannelItemWidget, 'Phòng chờ');
    //   await tester.tap(callChannel);
    //   await tester.pumpAndSettle();
    //   expect(find.byType(PrepareCallScreen), findsOneWidget);
    //   expect(find.text('Chat'), findsOneWidget);
    // });

    // testWidgets('go back button in prepare call screen test',
    //     (WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: const PrepareCallScreen(),
    //       navigatorObservers: [mockObserver],
    //     ),
    //   );

    //   final gobackButton = find.widgetWithIcon(ElevatedButton, Icons.expand_more);
    //   await tester.tap(gobackButton);
    //   await tester.pumpAndSettle();
    //   expect(find.byType(ChannelScreen), findsOneWidget);
    //   expect(find.text('J2Team'), findsOneWidget);
    // });

    testWidgets('call button in prepare call screen test',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const PrepareCallScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final callButton = find.widgetWithText(ElevatedButton, 'Tham gia');
      await tester.tap(callButton);
      await tester.pumpAndSettle();
      expect(find.byType(CallScreen), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
    });
  }
}

void main() {
  TestDiscordClone.run();
}
