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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sign_in_reference/screens/email_auth_screen.dart';
import 'package:flutter_sign_in_reference/screens/hw_auth_screen.dart';
import 'package:flutter_sign_in_reference/widgets/auth_rich_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white10, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Continue to your sign in process with:',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 17.0, color: Colors.amber),
                    ),
                  ),
                  authRichButton("Simple Build", " - Huawei ID", _navigateHWID),
                  authRichButton(
                      "Complex Build", " - Email + Huawei ID", _navigateEmail),
                ])
          ],
        ),
      ),
    );
  }

  _navigateHWID() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthScreen()));
  }

  _navigateEmail() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EmailScreen()));
  }
}
