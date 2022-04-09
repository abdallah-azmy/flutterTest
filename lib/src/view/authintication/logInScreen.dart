import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';
import 'package:fluttertest/src/controller/helper/route.dart';
import 'package:fluttertest/src/controller/provider/authenticationProvider.dart';
import 'package:fluttertest/src/view/authintication/signUpScreen.dart';
import 'package:fluttertest/src/view/widgets/linearLoadingWidget.dart';
import 'package:fluttertest/src/view/widgets/specialButton.dart';
import 'package:fluttertest/src/view/widgets/registerSecureTextField.dart';
import 'package:fluttertest/src/view/widgets/specialTextField.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(automaticallyImplyLeading: false),
          body: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "تسجيل دخول",
                    style: MyTheme.styleBlackBold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<AuthProvider>(
                    builder: (_, provider, __) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              child: Text(
                                "البريد الالكتروني",
                                style: MyTheme.styleBlack1,
                              ),
                            ),
                            SpecialTextField(
                              hint: "البريد الالكتروني",
                              icon: const Icon(Icons.phone),
                              color: MyTheme.grey,
                              type: TextInputType.emailAddress,
                              onChange: (v) {
                                provider.email = v;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              child: Text(
                                "كلمة المرور",
                                style: MyTheme.styleBlack1,
                              ),
                            ),
                            RegisterSecureTextField(
                              color: MyTheme.grey,
                              preIcon: const Icon(Icons.lock),
                              hint: "كلمة المرور",
                              onChange: (v) {
                                provider.password = v;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            provider.getLoader == true
                         ?   const LinearLoadingWidget()
                                : SpecialButton(
                                    text: "تسجيل",
                                    onTap: () {
                                      if (_form.currentState!.validate()) {
                                        provider.logIn();
                                      }
                                    },
                                  ),
                            const SizedBox(
                              height: 30,
                            ),
                            SpecialButton(
                              text: "تسجيل جديد",
                              color: MyTheme.black,
                              onTap: () {
                                push(context, const SignUpScreen());
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
