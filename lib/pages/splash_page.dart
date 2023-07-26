import 'package:flutter/material.dart';
import 'package:TWOS_Chatapp/constants/app_constants.dart';
import 'package:TWOS_Chatapp/constants/color_constants.dart';
import 'package:TWOS_Chatapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'pages.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // just delay for showing this slash page clearer because it too fast
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.darkgrey,
        body: Stack(
          // mainAxisSize: MainAxisSize.min,

          children: [
            Center(
              child: Image.asset(
                "images/app_icon.png",
                width: 150,
                height: 150,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text(
                  "Powered By TWOS",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
