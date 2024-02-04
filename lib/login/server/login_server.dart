

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../unit/unit.dart';

class AuthApi {

  static final storage = new FlutterSecureStorage();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: remotehost,
      connectTimeout: Duration(seconds: serverurl),
      receiveTimeout: Duration(seconds: serverurl),
    ),
  );

  Future<dynamic> Login(Map<String , dynamic> data) async{
    try{
      debugPrint("log1");
      FormData info = FormData.fromMap(data);
      Response response = await dio.post('/api/login', data: info);
      debugPrint("log2");
      if (response.data['result'] == "success") {
        debugPrint(response.data['token']);
        storeToken(response.data['token'].toString());
        storeUserName(response.data['user']['username'].toString());
        print(getToken());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.remove("save_token");
        // prefs.remove("save_name");
        prefs.setString("save_token", response.data['token']);
        prefs.setString("save_name", response.data['user']['username']);
        return response.data;
      }
      else {
        return response.data['result'];
      }
    }
    on DioError catch (e) {
      print("5555");
      // debugPrint(e.response!.statusMessage);
      return null;
    }
  }

  storeToken(String token) async {
    await storage.write(key: 'token', value: token);
  }
  Future getToken () async {
    return await storage.read(key: 'token');
  }

  storeUserName(String name) async {
    await storage.write(key: 'user_name', value: name);
  }
  Future getUserName () async {
    return await storage.read(key: 'user_name');
  }

}