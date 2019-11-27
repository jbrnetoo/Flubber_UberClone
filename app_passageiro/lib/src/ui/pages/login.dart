import 'package:flutter/material.dart';
import 'package:app_passageiro/src/ui/widgets/exhibition_bottom.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/triangle.png"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 10,
                        spreadRadius: 1)
                  ],
                  image: DecorationImage(
                      image: AssetImage("assets/images/flubber.png")),
                ),
                width: 200,
                height: 110,
                margin: EdgeInsets.only(bottom: 240),
              ),
            ),
        ),
        ExhibitionBottom()
      ],
      ),
    );
  }
}
