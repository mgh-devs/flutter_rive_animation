import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/widgets/custom_text_filde.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String pathAnimation = "assets/animated_login_character.riv";
  SMITrigger? trigFail, trigSuccess;
  SMIBool? isChecking, isHandsUp;
  SMINumber? numLook;
  Artboard? artBoard;
  StateMachineController? stateMachineController;
  final usernameCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  bool isShowPass = false;

  @override
  void initState() {
    initArtBoard();
    super.initState();
  }

  void initArtBoard() {
    rootBundle.load(pathAnimation).then((value) {
      final file = RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(art, "Login Machine");
      if (stateMachineController != null) {
        art.addController(stateMachineController!);
        //This for is the initial value
        for (var e in stateMachineController!.inputs) {
          if (e.name == "isChecking") {
            isChecking = e as SMIBool;
          } else if (e.name == "isHandsUp") {
            isHandsUp = e as SMIBool;
          } else if (e.name == "trigSuccess") {
            trigSuccess = e as SMITrigger;
          } else if (e.name == "trigFail") {
            trigFail = e as SMITrigger;
          } else if (e.name == "numLook") {
            numLook = e as SMINumber;
          }
        }
      }
      setState(() {
        artBoard = art;
      });
    });
  }

  void checking() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void handsUp() {
    isHandsUp?.change(true);
    isChecking?.change(false);
  }

  void look({required double value}) {
    numLook?.change(value);
  }

  void login() {
    isHandsUp?.change(false);
    isChecking?.change(false);

    if (usernameCtl.text == "are.zdevs" && passwordCtl.text == "2004") {
      trigSuccess!.fire();
    } else {
      trigFail!.fire();
    }
    usernameCtl.clear();
    passwordCtl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              artBoard != null
                  ? SizedBox(
                      width: 400,
                      height: 350,
                      child: Rive(artboard: artBoard!,fit: BoxFit.cover,),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: CustomTextField(
                  onTap: () {
                    setState(() {
                      checking();
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      look(value: val.length.toDouble());
                    });
                  },
                  controller: usernameCtl,
                  hint: "Username",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: CustomTextField(
                  onTap: () {
                    setState(() {
                      handsUp();
                    });
                  },
                  onTapObscure: () {
                    setState(() {
                      if (isShowPass) {
                        handsUp();
                      } else {
                        checking();
                      }
                    });
                    isShowPass = !isShowPass;
                  },
                  controller: passwordCtl,
                  hint: "Password",
                  obscureText: !isShowPass,
                ),
              ),
              MaterialButton(
                onPressed: () => login(),
                color: const Color(0xff1e81b0),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
