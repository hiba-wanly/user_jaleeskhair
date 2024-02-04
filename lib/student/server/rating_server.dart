import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:userjaleeskhair/student/datalayer/successfully_rating.dart';
import 'package:userjaleeskhair/unit/unit.dart';

class RatingApi{
  Dio dio = Dio(
    BaseOptions(
      baseUrl: remotehost,
      connectTimeout: Duration(seconds: serverurl),
      receiveTimeout: Duration(seconds: serverurl),
    ),
  );

  Future<SuccessfullyRating> createUpdateRating(Map<String, dynamic> data,dynamic token) async
  {
    try{
      debugPrint("get1");
      FormData info = FormData.fromMap(data);
      Response response = await dio.post('/api/rating_update_or_create',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              }
          ),
        data:  info,
      );
      debugPrint("get2");
      if(response.statusCode == 200) {
        debugPrint("get3");
        return SuccessfullyRating(userRatingModel: response.data['rating'],message: response.data['message']) ;
      }
      else {
        debugPrint("get4");
        return SuccessfullyRating(userRatingModel: null, message: null);
      }
    }on DioError catch(e){
      if(e.response!.statusCode == 401){
        return SuccessfullyRating(userRatingModel: null, message: 500);
      }
      if(e.response!.statusCode == 404){
        debugPrint(e.response!.data['message']);
        return SuccessfullyRating(userRatingModel: null, message: e.response!.data['message']);
      }
      debugPrint(e.response!.statusCode.toString());
      if(e.response!=null)
        debugPrint(e.response!.statusMessage.toString());
      else
        debugPrint(e.message);
      debugPrint("get5");
      return SuccessfullyRating(userRatingModel: null, message: null);
    }
  }

  // Future<dynamic> updateRating(Map<String, dynamic> data,dynamic token) async
  // {
  //   try{
  //     debugPrint("get1");
  //     FormData info = FormData.fromMap(data);
  //     Response response = await dio.post('/api/rating_update_or_create',
  //       options: Options(
  //           headers: {
  //             'Accept': 'application/json',
  //             'Authorization': 'Bearer $token'
  //           }
  //       ),
  //       data:  info,
  //     );
  //     debugPrint("get2");
  //     if(response.statusCode == 200) {
  //       debugPrint("get3");
  //       return response.data;
  //     }
  //     else {
  //       debugPrint("get4");
  //       return null;
  //     }
  //   }on DioError catch(e){
  //     if(e.response!.statusCode == 401){
  //       return 500;
  //     }
  //     if(e.response!.statusCode == 404){
  //       debugPrint(e.response!.data['message']);
  //       return e.response!.data['message'];
  //     }
  //     debugPrint(e.response!.statusCode.toString());
  //     if(e.response!=null)
  //       debugPrint(e.response!.statusMessage.toString());
  //     else
  //       debugPrint(e.message);
  //     debugPrint("get5");
  //     return null;
  //   }
  // }

  Future<dynamic> userBookRating(dynamic book_id, dynamic token) async
  {
    try{
      debugPrint("get1");
      Response response = await dio.get('/api/user_book_rating/${book_id}',
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
        return response.data[0];
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

  Future<List<dynamic>> userRatings(dynamic user_id, dynamic token) async
  {
    try{
      debugPrint("get1");
      Response response = await dio.get('/api/user_ratings/${user_id}',
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
        return [];
      }
    }on DioError catch(e){
      if(e.response!.statusCode == 401){
        // return 500;
        return [500];
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
      return [];
    }
  }

}