import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_passageiro/src/interfaces/pages/pagina_inicial.dart';

class PhoneAuthentication{

  String phoneNumber;
  String smsCode;
  String verificationId;
  BuildContext context;

  PhoneAuthentication({@required this.context, @required this.phoneNumber}) {
    verificarPhone();
  }
  
  Future<void> verificarPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value){
        print("Entrou");
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print('Verificado!');
    };

    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNumber,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 20),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Insira o código de SMS"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                  child: Text("Entrar"),
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then((user) {
                      if (user != null) {
                        Navigator.of(context).pop();
                        //Navigator.of(context).pushReplacementNamed("/homepage");
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                      } else {
                        Navigator.of(context).pop();
                        signIn();
                      }
                    });
                  })
            ],
          );
        }
    );
  }

  signIn() {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((user) {
      Navigator.of(context).pushReplacementNamed("/homepage");
    }).catchError((e) {
      print(e);
    });
  }
}
