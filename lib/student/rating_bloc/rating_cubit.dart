import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userjaleeskhair/login/server/login_server.dart';
import 'package:userjaleeskhair/student/datalayer/rating_model.dart';
import 'package:userjaleeskhair/student/rating_bloc/rating_state.dart';
import 'package:userjaleeskhair/student/server/info_server.dart';
import 'package:userjaleeskhair/student/server/rating_server.dart';

class RatingCubit extends Cubit<RatingState>{
  RatingCubit(RatingState initialState) : super(initialState);

  static RatingCubit get(context) => BlocProvider.of(context);

  RatingApi ratingApi = RatingApi();

  AuthApi authApi = AuthApi();

  RatingBook ratingBook = RatingBook();

  createRating(dynamic global_book_edition_id,
      dynamic title,
      dynamic description,
      dynamic rating,
      dynamic spoiler
      ) async
  {
    debugPrint("get01");
    emit(RatingLoadingState());
    String? token = await authApi.getToken();
    debugPrint(token);
    Map<String , dynamic> data = {
      'global_book_edition_id': global_book_edition_id,
      'title': title,
      'description': description,
      'rating': rating,
      'public': 0,
      // 'spoiler': spoiler
    };
    final ratingbook = await ratingApi.createRating(data,token);
    debugPrint("get02");
    debugPrint(ratingbook.toString());
    if(ratingbook != null){
      if(ratingbook == 500){
        emit(RatingNoTokenState());
      }
      else{
        emit(RatingCULoadingState(message: ratingbook.toString()));
      }
    }
    else {
      debugPrint("get0006");
      emit(RatingLoadedErrorState(message: 'لا يمكن اتمام العملية'));
    }
  }


  getUserBookRating(dynamic bookId) async
  {
    emit(RatingLoadingState());
    debugPrint("log3");
    String? token = await authApi.getToken();
    debugPrint(token);
    final response = await ratingApi.userBookRating(bookId,token);

    if(response != null){
      if(response == "User not found"){
        emit(RatingLoadedErrorState(message: response));
      }
      if(response == 500){
        emit(RatingNoTokenState());
      }
      else {
        debugPrint("log4");
        this.ratingBook =  RatingBook.fromJson(response);
        emit(RatingGetLoadedState(ratingBook: ratingBook));
      }
    }
    else{
      emit(RatingLoadedErrorState(message: "لا يمكن اتمام العملية"));
    }

  }


}