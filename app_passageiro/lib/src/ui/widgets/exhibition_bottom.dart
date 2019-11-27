import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:app_passageiro/src/ui/pages/phone_auth.dart';

const double minHeight = 230;
String phoneNo;
FocusNode focusNode;
FocusNode focusNodePassword;

class ExhibitionBottom extends StatefulWidget {
  @override
  _ExhibitionBottomState createState() => _ExhibitionBottomState();
}

class _ExhibitionBottomState extends State<ExhibitionBottom>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3600));
    focusNode = FocusNode();
  }

  double get headerTopMargin =>
      lerp(20, 20 + MediaQuery
          .of(context)
          .padding
          .top);

  double get headerFontSize => lerp(24, 34);

  double get maxHeight =>
      MediaQuery
          .of(context)
          .size
          .height;

  double get itemBorderRadius => lerp(8, 24);
  double get iconLeftBorderRadius => itemBorderRadius;
  double get iconRightBorderRadius => lerp(8, 0);
  double lerp(double min, double max) => lerpDouble(min, max, _controller.value);

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   phoneTextController.dispose();
  //   passwordTextController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Positioned(
            height: lerp(minHeight, maxHeight),
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: _toogle,
                              child: Container(
                                color: Colors.transparent,
                                child: IgnorePointer(
                                  child: TextField(
                                    onChanged: (text) {
                                      setState(() {
                                        phoneNo = text;
                                      });
                                    },
                                    focusNode: focusNode,
                                    keyboardType: TextInputType.phone,
                                    onSubmitted: (text) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Container(
                                          width: 50,
                                          child: Icon(Icons.smartphone),
                                        ),
                                        border: InputBorder.none,
                                        labelText: "Entre com o número do celular",
                                        labelStyle: TextStyle(
                                            fontFamily: "Kanit",
                                            fontSize: 16
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    _builtBotaoFlutuante(),
                    _builtVamosComecar(),
                    _builtCriarConta()
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _builtBotaoFlutuante() {
    return BotaoFlutuante(
      isVisible: _controller.status == AnimationStatus.completed,
    );
  }

  Widget _builtVamosComecar() {
    return CreateVamosComecar(
      isVisible: _controller.status != AnimationStatus.completed,
    );
  }

  Widget _builtCriarConta() {
    return CriarNovaConta(
      isVisible: _controller.status != AnimationStatus.completed,
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;
  }

  void _toogle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    print(isOpen.toString());
    _controller.fling(velocity: 0.1); //isOpen ? -2 :

    FocusScope.of(context).requestFocus(focusNode);
  }
}

class BotaoFlutuante extends StatelessWidget {
  final double bottomMargin;
  final bool isVisible;

  const BotaoFlutuante({Key key, this.bottomMargin, this.isVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      right: 20,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: RawMaterialButton(
          onPressed: () => PhoneAuthentication(context: context, phoneNumber: phoneNo),
          splashColor: Colors.white,
          fillColor: Colors.lightBlue,
          elevation: 15.0,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              Icons.arrow_forward,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


class CreateVamosComecar extends StatelessWidget {
  final bool isVisible;

  const CreateVamosComecar({Key key, this.isVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 32.0,
        left: 38.0,
        child: AnimatedOpacity(
            opacity: isVisible ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: Text("Vamos Começar...",
                style: TextStyle(fontSize: 26,
                    fontFamily: "Kanit Light",
                    fontWeight: FontWeight.w500))));
  }
}

class CriarNovaConta extends StatelessWidget {
  final bool isVisible;

  const CriarNovaConta({Key key, this.isVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 40,
        left: 40,
        child: AnimatedOpacity(
          opacity: isVisible ? 1 : 0,
          duration: Duration(milliseconds: 200),
          child: GestureDetector(
              onTap: () {
                 Navigator.pushNamed(context, '/homepage');
              },
              child: Text("SOBRE NÓS",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Kanit", color: Colors.blue))),
        )
    );
  }
}

