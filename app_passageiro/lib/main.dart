import 'package:flutter/material.dart';
import 'package:app_passageiro/src/ui/pages/login.dart';
import 'package:app_passageiro/src/ui/pages/home_page.dart';

void main() => runApp(FlubberApp());

class FlubberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flubber",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: './',
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => HomePage(),
        '/': (context) => LoginView(),
        // '/payment': (context) => PaymentPage(),
        // '/add_payment': (context) => AddPaymentMethodPage(),
        // '/add_card': (context) => AddCardPage(),
        // '/your_trip': (context) => YourTripPage(),
        // '/select_issue': (context) => SelectIssuePage(),
        // '/free_rides': (context) => FreeRidesPage(),
        // '/help': (context) => HelpPage(),
        // '/settings': (context) => SettingsPage(),
      },
    );
  }
}
