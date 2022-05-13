import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student/src/shared/helpers/colors/hex_color.dart';
import 'package:student/src/shared/theme/colors/app_colors.dart';
import '../../student/shared-widgets/menu/bottom_navigation.dart';
import '../../authentication/services/authentication_service.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authenticationService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  String _userEmail = '';
  String _password = '';

  bool submitted = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _formKey.currentState!.validate();
      });
    });
    _passwordController.addListener(() {
      if (_formKey.currentState != null) {
        setState(() {
          _formKey.currentState!.validate();
        });
      }
    });
  }

  void _submitSignin() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      setState(() {
        submitted = true;
      });
      var response = await authenticationService
          .login(_userEmail, _password)
          .whenComplete(() => setState(() {
                submitted = false;
              }));
      if (response != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const BottomNavigation()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Center(
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 0, top: 25),
                          width: 150,
                          height: 50,
                          child: Image.asset('assets/images/logo.png')),
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(35),
                        child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, left: 15, right: 15),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 25),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .login,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor.fromHex(
                                                    AppColors.primaryColor)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor.fromHex(
                                                    AppColors
                                                        .backgroundColorGray)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor.fromHex(
                                                    AppColors
                                                        .backgroundColorGray)),
                                          ),
                                          helperText: ' ',
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .email,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: _emailController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return '';
                                          }
                                          if (!RegExp(r'\S+@\S+\.\S+')
                                              .hasMatch(value)) {
                                            return '';
                                          }

                                          return null;
                                        },
                                        onChanged: (value) =>
                                            _userEmail = value,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor.fromHex(
                                                    AppColors.primaryColor)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor.fromHex(
                                                    AppColors
                                                        .backgroundColorGray)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor.fromHex(
                                                    AppColors
                                                        .backgroundColorGray)),
                                          ),
                                          helperText: ' ',
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .password,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: _passwordController,
                                        obscureText: !_passwordVisible,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return '';
                                          }
                                          if (value.trim().length < 2) {
                                            return '';
                                          }

                                          return null;
                                        },
                                        onChanged: (value) => _password = value,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 0, bottom: 20),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .forgotPassword,
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          )
                                        ],
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(60),
                                              primary: HexColor.fromHex(
                                                  AppColors.primaryColor),
                                              padding:
                                                  const EdgeInsets.all(20)),
                                          onPressed:
                                              _formKey.currentState != null
                                                  ? _formKey.currentState!
                                                              .validate() &&
                                                          !submitted
                                                      ? _submitSignin
                                                      : null
                                                  : null,
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .login,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20))),
                                    ]),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          top: 30, left: 15, right: 15),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Center(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .loginWithSocialNetworks,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 15),
                                              child: ElevatedButton.icon(
                                                icon: Container(
                                                    margin:
                                                        const EdgeInsets.all(2),
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/images/google-login-icon.png')),
                                                style: ButtonStyle(
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 10,
                                                              left: 5,
                                                              right: 5)),
                                                ),
                                                label: Text(AppLocalizations.of(
                                                        context)!
                                                    .loginWithGoogle),
                                                onPressed: () async {
                                                  var response =
                                                      await authenticationService
                                                          .signInGoogle();
                                                  if (response != null &&
                                                      response) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const BottomNavigation()));
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ])),
                                ]))),
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: HexColor.fromHex(AppColors.backgroundColorAlto),
                ),
              )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.noAccount + " ",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: InkWell(
                              child: Text(
                                AppLocalizations.of(context)!.signUp,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (_) => const SignupScreen()));
                              },
                            ))
                      ],
                    ),
                  ]),
            )
          ],
        ));
  }
}
