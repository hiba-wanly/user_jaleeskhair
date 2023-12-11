

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userjaleeskhair/login/datalayer/store_user.dart';
import 'package:userjaleeskhair/student/bloc/state_info.dart';
import 'package:userjaleeskhair/student/datalayer/book_model.dart';
import 'package:userjaleeskhair/student/datalayer/user_model.dart';
import 'package:userjaleeskhair/student/datalayer/user_rating_model.dart';
import 'package:userjaleeskhair/student/server/info_server.dart';
import 'package:userjaleeskhair/student/server/rating_server.dart';

class InfoCubit extends Cubit<InfoState>{
  InfoCubit(InfoState initialState) : super(initialState);

  static InfoCubit get(context) => BlocProvider.of(context);

  InfoApi infoApi = InfoApi();

  RatingApi ratingApi = RatingApi();

  late UserAccountInfo userAccountInfo;

  List<Users> user = [];

  List<UserRatingModel> userrating = [];

  GetInfo(dynamic username,dynamic token) async {
    emit(InfoLoadingState());
    debugPrint("log3");
    final response = await infoApi.UserStatus(username,token);
    if(response != null){
      if(response == "User not found"){
        emit(InfoLoadedErrorState(message: response));
      }
      if(response == 500){
        emit(NoTokenState());
      }
      else {
        user = await getUsers();
        debugPrint(user.toString());
        debugPrint("log4");
        this.userAccountInfo =  UserAccountInfo.fromJson(response);
        final response22 = await ratingApi.userRatings(userAccountInfo.userId,token);
        if(response22 == 500){
          emit(NoTokenState());
        }
        Map<int,dynamic> userRatingBook = {};

        Map<int,dynamic> uniqueBooksCounter = {};
        Map<int, String> uniqueBooksDate = {};

        List<Books> allBooks = userAccountInfo.returnedBorrows!;
        // print(allBooks.toString());
        allBooks.forEach((book) {

          if(! uniqueBooksCounter.containsKey(book.localBookId))             // اذا أول مرة عم نشوف الكتاب
              {
            uniqueBooksCounter[book.localBookId]=1;                       //ضيفه لقائمةالكتب وخليه العداد عنده واحد
            uniqueBooksDate[book.localBookId]=book.borrowStartDate;  // حط تاريخ استعارته كتاريخ آخر استعارة
          }

          else // اذا مو اول مرة عم نشوف الكتب يعني شايفينه من قبل
              {
            uniqueBooksCounter[book.localBookId]+=1;  //زود العداد عنده واحد

            String borrowStartDate = book.borrowStartDate;
            DateFormat format = DateFormat("dd-MM-yyyy");
            DateTime dateTime = format.parse(borrowStartDate);

            // print(uniqueBooksDate.toString());
            String borrowStartDate2 = uniqueBooksDate[book.localBookId]!;
            DateTime dateTime2 = format.parse(borrowStartDate2);
            if(dateTime.isAfter(dateTime2)) // وقارن اذا تاريخ الاستعارة الحالي أحدث من تاريخ الاستعارة المسجل
                {
              uniqueBooksDate[book.localBookId] = book.borrowStartDate;
            }
          }

        });

        if(response22 != null){
          this.userrating = response22.map((e) => UserRatingModel.fromJson(e)).toList();
          allBooks.forEach((book){
            userRatingBook[book.localBookId]=0;
          });

        }

        allBooks = allBooks.toSet().toList();


        if(allBooks.isNotEmpty)
        {

          debugPrint("NNNNNNNN111");
          emit(InfoLoadedState(userAccountInfo,allBooks, uniqueBooksCounter, uniqueBooksDate,user));
        }

        else
        {
          debugPrint("NNNNNNNN222");
          emit(InfoLoadedState22(userAccountInfo,user));
        }

        // emit(InfoLoadedState(infomodel: userAccountInfo));
      }
    }
    else{
      emit(InfoLoadedErrorState(message: "لا يمكن اتمام العملية"));
    }

  }

  Future<List<Users>> getUsers () async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> userString = pref.getStringList('user') ?? [];

    List<Users> user = [];

    if(userString.isNotEmpty){
      userString.forEach((element) {

        Map<String, dynamic> json = jsonDecode(element);

        Users user1 = Users.fromJson(json);

        user.add(user1);
      });
      return user;
    }
    else {
      return [];
    }

  }

}