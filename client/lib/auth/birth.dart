// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebeal/Auth/signup.dart';
import '../animation/animation.dart';
import '../widget/custom/rippleButton.dart';

class BirthPage extends StatefulWidget {
  String name;
  final VoidCallback? loginCallback;
  BirthPage({Key? key, required this.name, this.loginCallback})
      : super(key: key);

  @override
  _BirthPageState createState() => _BirthPageState();
}

bool empt = false;

class _BirthPageState extends State<BirthPage> {
  final _birthController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _birthController.text.isNotEmpty ? empt = true : empt = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            setState(() {
              Navigator.pop(context);
            });
          }
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Image.asset(
                "assets/rebeals.png",
                height: 130,
              ),
              backgroundColor: Colors.black,
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                ),
                Text(
                  "Hello ${widget.name}, what is you're birthday ?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        _birthController.text.isNotEmpty
                            ? empt = true
                            : empt = false;
                      });
                      if (_birthController.text.length == 2) {
                        _birthController.text = _birthController.text + " ";
                        _birthController.selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: _birthController.text.length,
                                affinity: TextAffinity.upstream));
                      }
                      if (_birthController.text.length == 5) {
                        _birthController.text = _birthController.text + " ";
                        _birthController.selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: _birthController.text.length,
                                affinity: TextAffinity.upstream));
                      }
                      if (_birthController.text.length >= 11) {
                        _birthController.text = _birthController.text
                            .substring(0, _birthController.text.length - 1);
                      }
                    },
                    keyboardType: TextInputType.number,
                    keyboardAppearance: Brightness.dark,
                    controller: _birthController,
                    decoration: InputDecoration(
                        hintText: 'DD MM YYYY',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 60, 60, 60),
                            fontSize: 38,
                            fontWeight: FontWeight.w800)),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w800)),
              ],
            ),
            bottomSheet: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RippleButton(
                        splashColor: Colors.transparent,
                        child: Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: empt || _birthController.text.isNotEmpty
                                  ? Colors.white
                                  : Color.fromARGB(255, 61, 61, 61),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontFamily: "icons.ttf",
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ))),
                        onPressed: () {
                          if (_birthController.text.isNotEmpty) {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              AwesomePageRoute(
                                transitionDuration: Duration(milliseconds: 600),
                                exitPage: widget,
                                enterPage: Signup(
                                    name: widget.name,
                                    birth: _birthController.text),
                                transition: ZoomOutSlideTransition(),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ))));
  }
}
