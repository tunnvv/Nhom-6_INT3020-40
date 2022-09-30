import 'package:discord_clone/constants.dart';
import 'package:flutter/material.dart';

class SinginScreen extends StatelessWidget {
  const SinginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      // backgroundColor: Color.fromRGBO(85, 130, 131, 89),
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: 80,
                left: 40,
                right: 35,
                child: Text(
                  "Chào mừng trở lại!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryLightColor,
                  ),
                )
            ),
            Positioned(
                top: 125,
                left: 40,
                right: 35,
                child: Text(
                  "Rất vui mừng khi được gặp lại bạn!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryLightColor,
                  ),
                )
            ),
            Positioned(
                top: 175,
                left: 20.0,
                right: 18.0,
                child: Text(
                  "THÔNG TIN TÀI KHOẢN",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryLightColor,
                  ),
                )
            ),
            Positioned(
                top: 200.0,
                left: 20.0,
                right: 18.0,
                child: SizedBox(
                    width: 130.0,
                    height: 45.0,
                    child: Theme(
                      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        autofocus: false,
                        style: TextStyle(fontSize: 18, color: kPrimaryLightColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black38,
                          hintText: "Email hoặc số điện thoại",
                          hintStyle: TextStyle(fontSize: 18.0, color: Colors.black26,),
                    ),
                      ),
                    ),
                ),
            ),
            Positioned(
              top: 251.0,
              left: 20.0,
              right: 18.0,
              child: SizedBox(
                width: 130.0,
                height: 45.0,
                child: Theme(
                  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    autofocus: false,
                    style: TextStyle(fontSize: 18, color: kPrimaryLightColor),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black38,
                        hintText: "Mật khẩu",
                        hintStyle: TextStyle(fontSize: 18.0, color: Colors.black26,),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 295,
              left: 80,
              right: 75,
              child: Theme(
                data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                child: TextButton(
                  onPressed: () {  },
                  child: Text(
                      "Quên mật khẩu?",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          color: kPrimaryLightColor,
                      ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 365.0,
              left: 20.0,
              right: 16.0,
              child: SizedBox(
                height: 45.0,
                width: 130,
                child: TextButton(
                  onPressed: () {  },
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                        color: kPrimaryLightColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kBntSingupColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
