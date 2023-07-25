import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../animation/animation.dart';
import '../widget/custom/rippleButton.dart';
import 'birth.dart';

class NamePage extends StatefulWidget {
  final VoidCallback? loginCallback;
  const NamePage({Key? key, this.loginCallback}) : super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

bool empt = false;

class _NamePageState extends State<NamePage> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _nameController.text.isNotEmpty ? empt = true : empt = false;
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
                  "Lets go, whats you're name ?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        _nameController.text.isNotEmpty
                            ? empt = true
                            : empt = false;
                      });
                    },
                    keyboardAppearance: Brightness.dark,
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: 'You\'re name',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 60, 60, 60),
                            fontSize: 45,
                            fontWeight: FontWeight.w800)),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
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
                              color: empt || _nameController.text.isNotEmpty
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
                          if (_nameController.text.isNotEmpty &&
                              _nameController.text.length < 30) {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              AwesomePageRoute(
                                transitionDuration: Duration(milliseconds: 600),
                                exitPage: widget,
                                enterPage:
                                    BirthPage(name: _nameController.text),
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
