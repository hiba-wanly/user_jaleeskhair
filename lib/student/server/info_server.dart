import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:userjaleeskhair/unit/unit.dart';

class InfoApi{
  Dio dio = Dio(
    BaseOptions(
      baseUrl: remotehost,
      connectTimeout: Duration(seconds: serverurl),
      receiveTimeout: Duration(seconds: serverurl),
    ),
  );

  Future<dynamic> UserStatus(dynamic username,dynamic token) async
  {
    try{
      debugPrint("get1");
      Response response = await dio.get('/api/user_borrow_status/${username}',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              }
          )
      );
      debugPrint("get2");
      if(response.statusCode == 200) {
        debugPrint("get3");
        return response.data;
      }
      else {
        debugPrint("get4");
        return null;
      }
    }on DioError catch(e){
      if(e.response!.statusCode == 401){
        return 500;
      }
      if(e.response!.statusCode == 404){
        debugPrint(e.response!.data['message']);
        return e.response!.data['message'];
      }
      debugPrint(e.response!.statusCode.toString());
      if(e.response!=null)
        debugPrint(e.response!.statusMessage.toString());
      else
        debugPrint(e.message);
      debugPrint("get5");
      return null;
    }
  }



}