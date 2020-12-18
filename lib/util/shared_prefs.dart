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

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }
  bool getBool(String sharedPrefParam) {
    return _sharedPrefs.getBool(sharedPrefParam);
  }
  void setBool(String sharedPrefParam, bool value) {
    _sharedPrefs.setBool(sharedPrefParam, value);
  }

  int getInt(String sharedPrefParam) {
    return _sharedPrefs.getInt(sharedPrefParam);
  }
  void setInt(String sharedPrefParam, int value) {
    _sharedPrefs.setInt(sharedPrefParam, value);
  }

  String getString(String sharedPrefParam) {
    return _sharedPrefs.getString(sharedPrefParam);
  }
  void setString(String sharedPrefParam, String value) {
    _sharedPrefs.setString(sharedPrefParam, value);
  }
}

final sharedPrefs = SharedPrefs();
