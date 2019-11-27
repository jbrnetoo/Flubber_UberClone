import 'package:flutter/material.dart';

class HomeMenuDrawer extends StatefulWidget {
  HomeMenuDrawer({Key key}) : super(key: key);

  _HomeMenuDrawerState createState() => _HomeMenuDrawerState();
}

class _HomeMenuDrawerState extends State<HomeMenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.lightBlue[200]),
          accountName: Text("João Neto"),
          accountEmail: Row(
            children: <Widget>[
              Text("5.0"),
              Icon(
                Icons.star,
                color: Colors.white,
                size: 12,
              )
            ],
          ),
          currentAccountPicture: ClipOval(
            child: Image.asset(
              "assets/images/user_profile.jpg",
              width: 10,
              height: 10,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          linkMenuDrawer('Pagamento', () {
            Navigator.pushNamed(context, '/payment');
          }),
          linkMenuDrawer('Suas Viagens', () {
            Navigator.pushNamed(context, '/your_trip');
          }),
          linkMenuDrawer('Corridas', () {
            Navigator.pushNamed(context, '/homepage');
          }),
          linkMenuDrawer('Ajuda', () {
            Navigator.pushNamed(context, '/homepage');
          }),
          linkMenuDrawer('Configurações', () {
            Navigator.pushNamed(context, '/homepage');
          }),
        ]),
      ],
    );
  }
}

Widget linkMenuDrawer(String title, Function onPressed) {
  return InkWell(
    onTap: onPressed,
    splashColor: Colors.blueAccent,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(fontSize: 15.0),
      ),
    ),
  );
}
