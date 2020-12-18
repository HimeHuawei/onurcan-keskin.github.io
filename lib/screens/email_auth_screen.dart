/*
 * Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sign_in_reference/screens/welcome_screen.dart';
import 'package:flutter_sign_in_reference/util/shared_prefs.dart';
import 'package:flutter_sign_in_reference/util/validator.dart';
import 'package:http/http.dart' as http;
import 'package:huawei_account/auth/auth_huawei_id.dart';
import 'package:huawei_account/helpers/auth_param_helper.dart';
import 'package:huawei_account/helpers/scope.dart';
import 'package:huawei_account/hms_account.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  bool isLoginPage;
  bool isLoading;

  final _signInFormKey = GlobalKey<FormState>();
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isLoginPage = true;
  }

  @override
  void dispose() {
    super.dispose();
    signUpEmail.dispose();
    signUpPassword.dispose();
    signUpName.dispose();
    signInEmail.dispose();
    isLoading = false;
  }

  _signIn() async {
    // BUILD DESIRED PARAMS
    AuthParamHelper authParamHelper = new AuthParamHelper();
    authParamHelper
      ..setIdToken()
      ..setAuthorizationCode()
      ..setAccessToken()
      ..setProfile()
      ..setEmail()
      ..setId()
      ..addToScopeList([Scope.openId])..setRequestCode(8888);
    // GET ACCOUNT INFO FROM PLUGIN
    try {
      final AuthHuaweiId accountInfo = await HmsAccount.signIn(authParamHelper);
      setState(() {

      });
    } on Exception catch(exception) {
      print(exception.toString());
    }
    /// TO VERIFY ID TOKEN, AuthParamHelper()..setIdToken()
    //performServerVerification(accountInfo.idToken);
  }

  requestSignUpHandler(response) {
    if (response != null && response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['result'] == true) {
        loginProcedure(json['token']);
      }
      else {
        _alreadyTakenEmailError();
      }
    }
    else {
      // another error occured
      _someErrorHappenedAlert();
    }
  }

  requestSignInHandler(response) {
    if (response != null && response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['result'] == true && json['token'] != null) {
        loginProcedure(json['token']);
      }
      else {
        _authenticationError();
      }
    }
    else {
      // another error occured
      _someErrorHappenedAlert();
    }
  }

  void loginProcedure(token) {
    sharedPrefs.setString("token", token);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WelcomeScreen()));
  }

  Future<void> _someErrorHappenedAlert() async {
    setState(() {
      isLoading = !isLoading;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Something Went Wrong!', style: TextStyle(
            fontSize: 16,
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('An error occurred during request.'),
                Text('Please check your connection.'),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 30),
          actions: <Widget>[
            FlatButton(
              child: Text('OK', style: TextStyle(color: Colors.blue),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _alreadyTakenEmailError() async {
    setState(() {
      isLoading = !isLoading;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Address is in Use!', style: TextStyle(
            fontSize: 16,
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter another email address.'),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 30),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Change Address', style: TextStyle(color: Colors.blue),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _authenticationError() async {
    setState(() {
      isLoading = !isLoading;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Authentication Failed', style: TextStyle(
            fontSize: 16,
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please check your email and password.'),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 30),
          actions: <Widget>[
            FlatButton(
              child: Text('OK', style: TextStyle(color: Colors.blue),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var divider = Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(children: <Widget>[
        Expanded(
          child: new Container(
            margin: const EdgeInsets.only(left: 10.0,right: 20.0),
            child: Divider(
              color: Colors.white24,
              height: 36,
              thickness: 0.7
            )),
        ),
        Text("or", style: TextStyle(color: Colors.white24, fontSize: 24),),
        Expanded(
          child: new Container(
            margin: const EdgeInsets.only(left: 20.0,right: 10.0),
            child: Divider(
              color: Colors.white24,
                height: 36,
                thickness: 0.7
            )),
        )
      ]),
    );

    var signInPage = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: isLoading,
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                      children: <Widget> [
                        SizedBox(height: 50),
                        Text("Flutter Log In Reference", style: TextStyle(
                            fontSize: 30,
                            color: Colors.amber
                        ),),
                        SizedBox(height: 60),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: signInEmail,
                          obscureText: false,
                          autofocus: false,
                          maxLines: 1,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) {
                            if(Validator.isValidEmail(input.toString())) {
                              return null;
                            } else {
                              return "Please enter a valid email.";
                            }
                          },
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          cursorColor: Colors.amber,
                          style: TextStyle(fontSize: 16, color: Colors.white,),
                          decoration: InputDecoration(
                              enabled: true,
                              prefixIcon: Icon(Icons.email, color: Colors.amber,size: 18,),
                              focusColor: Colors.amber,
                              contentPadding: EdgeInsets.all(10),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              hintText: "Email Address",
                              hintStyle: TextStyle(color: Colors.white54)
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: signInPassword,
                          obscureText: true,
                          autofocus: false,
                          maxLines: 1,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (input) {
                            if(input.toString().length >= 6) {
                              return null;
                            } else {
                              return "Please enter your password.";
                            }
                          },
                          cursorColor: Colors.amber,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                              enabled: true,
                              prefixIcon: Icon(Icons.lock, color: Colors.amber,size: 18),
                              focusColor: Colors.amber,
                              contentPadding: EdgeInsets.all(10),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.white54)
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => {
                                   // Navigator.pushNamed(context, ForgotPasswordPage.route),
                                  },
                                  splashColor: Colors.amber,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    child: Text('Forgot Password', style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    )),
                                  ),
                                )
                              ],
                            )
                        ),
                        Container(
                          height: 36,
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.red)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                isLoading ? SizedBox() : Icon(Icons.email, color: Colors.white70.withOpacity(0.4), size: 22),
                                isLoading ? SizedBox(height:22, width:22,child: CircularProgressIndicator(strokeWidth: 4,)) : Text('Sign in with Email', style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),),
                                isLoading ? SizedBox() : SizedBox(width: 26,),
                              ],
                            ),
                            color: Colors.white12,
                            focusColor: Colors.amber,
                            splashColor: Colors.amber,
                            onPressed: () {
                              if (_signInFormKey.currentState.validate()) {
                                setState(() {
                                  isLoading = !isLoading;
                                });
                                //requestSignIn().then((response) => (requestSignInHandler(response)));
                              }
                            },
                          ),
                        ),
                        divider,
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                          height: 36,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.red)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset('assets/images/hw_24x24_logo.png', width: 24, height: 24),
                                Text('Sign in with HUAWEI ID', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                                SizedBox(width: 20,),
                              ],
                            ),
                            color: Color(0xffef484b),
                            focusColor: Colors.amber,
                            splashColor: Colors.amber,
                            onPressed: () {
                              _signIn();
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account yet?', style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),),
                              InkWell(
                                onTap: () => {
                                  setState(() {
                                    isLoginPage = !isLoginPage;
                                  })
                                },
                                focusColor: Colors.amber,
                                splashColor: Colors.amber,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  child: Text('Register', style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.2,
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
    var signUpPage = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: isLoading,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                      children: <Widget> [
                        SizedBox(height: 50,),
                        Text("Flutter Sign In Reference", style: TextStyle(
                          fontSize: 30,
                          color: Colors.amber,
                        ),),
                        SizedBox(height: 60,),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: signUpName,
                          obscureText: false,
                          autofocus: false,
                          maxLines: 1,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (input) {
                            if(input.toString().length >= 3) {
                              return null;
                            } else {
                              return "Please enter your name.";
                            }
                          },
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          cursorColor: Colors.amber,
                          style: TextStyle(fontSize: 16, color: Colors.white,),
                          decoration: InputDecoration(
                              enabled: true,
                              prefixIcon: Icon(Icons.account_box, color: Colors.amber,size: 18,),
                              focusColor: Colors.amber,
                              contentPadding: EdgeInsets.all(10),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              hintText: "Enter your Name",
                              hintStyle: TextStyle(color: Colors.white54)
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: signUpEmail,
                          obscureText: false,
                          autofocus: false,
                          maxLines: 1,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) {
                            if(Validator.isValidEmail(input.toString())) {
                              return null;
                            } else {
                              return "Please enter a valid email.";
                            }
                          },
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          cursorColor: Colors.amber,
                          style: TextStyle(fontSize: 16, color: Colors.white,),
                          decoration: InputDecoration(
                              enabled: true,
                              prefixIcon: Icon(Icons.email, color: Colors.amber,size: 18,),
                              focusColor: Colors.amber,
                              contentPadding: EdgeInsets.all(10),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              hintText: "Enter your Email",
                              hintStyle: TextStyle(color: Colors.white54)
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: signUpPassword,
                          obscureText: true,
                          autofocus: false,
                          maxLines: 1,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (input) {
                            if(input.toString().length >= 6) {
                              return null;
                            } else {
                              return "Your password must contain at least 6 characters.";
                            }
                          },
                          cursorColor: Colors.amber,
                          style: TextStyle(fontSize: 16, color: Colors.white,),
                          decoration: InputDecoration(
                              enabled: true,
                              prefixIcon: Icon(Icons.lock, color: Colors.amber,size: 18),
                              focusColor: Colors.amber,
                              contentPadding: EdgeInsets.all(10),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber, width: 2),
                              ),
                              hintText: "Enter your a Password",
                              hintStyle: TextStyle(color: Colors.white54)
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?', style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),),
                              InkWell(
                                onTap: () => {
                                  setState(() {
                                    isLoginPage = !isLoginPage;
                                  })
                                },
                                splashColor: Colors.amber,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  child: Text('Sign In', style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.5,
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                          height: 36,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.red)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                isLoading ? SizedBox(height:22, width:22,child: CircularProgressIndicator(strokeWidth: 4,)) : Text('Sign Up'.toUpperCase(), style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                )),
                              ]),
                            color: Colors.white24,
                            focusColor: Colors.amber,
                            splashColor: Colors.amber,
                            onPressed: () {
                              if (_signUpFormKey.currentState.validate()) {
                                setState(() {
                                  isLoading = !isLoading;
                                });
                               // requestSignUp().then((response) => (requestSignUpHandler(response)));
                              }
                            },
                          ),
                        ),
                        divider,
                        Container(
                          height: 36,
                          margin: EdgeInsets.symmetric(horizontal:0,vertical: 4),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.red)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset('assets/images/hw_24x24_logo.png', width: 24, height: 24),
                                Text('Sign in with HUAWEI ID', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),),
                                SizedBox(width: 20,),
                              ],
                            ),
                            color: Color(0xffef484b),
                            onPressed: () {

                            },
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('Complex Build'),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white10, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
            child: isLoginPage ? signInPage : signUpPage
        )
    );

  } // Widget

}
