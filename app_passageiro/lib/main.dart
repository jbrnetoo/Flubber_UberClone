import 'package:flutter/material.dart';
import 'package:app_passageiro/src/interfaces/pages/login.dart';
import 'package:app_passageiro/src/interfaces/pages/pagina_inicial.dart';
import 'package:app_passageiro/src/interfaces/pages/pagamento.dart';
import 'package:app_passageiro/src/interfaces/pages/adicionar_pagamento.dart';
import 'package:app_passageiro/src/interfaces/pages/minhas_viagens.dart';

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
        '/payment': (context) => PaymentPage(),
        '/add_payment': (context) => AddPaymentMethodPage(),
        '/your_trip': (context) => YourTripPage(),
      },
    );
  }
}
