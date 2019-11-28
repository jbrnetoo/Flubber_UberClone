import 'package:flutter/material.dart';

class AddPaymentMethodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddPaymentMethodView();
  }
}

class AddPaymentMethodView extends StatefulWidget {
  @override
  _AddPaymentMethodViewState createState() => _AddPaymentMethodViewState();
}

class _AddPaymentMethodViewState extends State<AddPaymentMethodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        title: Text("Adicionar Método de Pagamento"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          padding: EdgeInsets.only(left: 20),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
                          child: Row(
                children: <Widget>[
                  Icon(Icons.payment),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(onTap: () {Navigator.pushNamed(context, "/add_card");}, child: Text("Cartão de Crédito ou Débito")),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
                          child: Row(
                children: <Widget>[
                  Icon(Icons.payment),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Paypal"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
