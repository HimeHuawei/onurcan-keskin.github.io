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

import 'package:flutter/material.dart';
class CustomLoadingDialog {

  static var _widget = Dialog(
    child: Center(
      heightFactor: 1.6,
      widthFactor: 1,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          new CircularProgressIndicator(),
          SizedBox(height: 24,),
          new Text("Loading", style: TextStyle(
              color: Colors.black54,
              fontSize: 15
          ),),
        ],
      ),
    ),
  );

  static get widget => _widget;
}
