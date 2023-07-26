import 'package:flutter/material.dart';
import 'package:TWOS_Chatapp/constants/app_constants.dart';
import 'package:TWOS_Chatapp/constants/color_constants.dart';
import 'package:TWOS_Chatapp/providers/auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/pattern.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        bool isSuccess = await authProvider.handleSignIn();
                        if (isSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.google,
                        size: 18,
                        color: Colors.white,
                      ),

                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),

                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white, width: 1.5),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      //     (Set<MaterialState> states) {
                      //       if (states.contains(MaterialState.pressed))
                      //         return Color(0xffdd4b39).withOpacity(0.8);
                      //       return Color(0xffdd4b39);
                      //     },
                      //   ),
                      //   splashFactory: NoSplash.splashFactory,
                      //   padding: MaterialStateProperty.all<EdgeInsets>(
                      //     EdgeInsets.fromLTRB(30, 15, 30, 15),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),

              // Loading
              Positioned(
                child: authProvider.status == Status.authenticating
                    ? LoadingView()
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
