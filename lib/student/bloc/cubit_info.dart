

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userjaleeskhair/login/datalayer/store_user.dart';
import 'package:userjaleeskhair/login/server/login_server.dart';
import 'package:userjaleeskhair/student/bloc/state_info.dart';
import 'package:userjaleeskhair/student/datalayer/book_model.dart';
import 'package:userjaleeskhair/student/datalayer/rating_model.dart';
import 'package:userjaleeskhair/student/datalayer/successfully_rating.dart';
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

  List<Books> allBooks = [];

  List<Books> allBooksafter  = [];
  AuthApi authApi = AuthApi();

  RatingBook ratingBook = RatingBook();

  late UserRatingModel userRatingModel;

  bool addRating = false ;

  Map<int,dynamic> newRatings = {};



  GetInfo(/*dynamic username,dynamic token*/) async {
    // SharedPreferences.getInstance().then((shard){
    //     token = shard.getString("save_token");
    //     name = shard.getString("save_name");
    //     // debugPrint("ttttttt"+token!);
    //     debugPrint('***********');
    // });
    String? token = await  authApi.getToken();
    String? name = await  authApi.getUserName();

    debugPrint("HERERERER");
    debugPrint(name);
    debugPrint(token);
    emit(InfoLoadingState());
    debugPrint("log3");
    final response = await infoApi.UserStatus(name,token);
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

        this.allBooks = userAccountInfo.returnedBorrows!;

        print("GGGGGGGGGGGGGg"+this.allBooks.length.toString());
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

        if(response22 != null && response22 != 500){
          print("66644442");

          this.userrating = response22.map((e) => UserRatingModel.fromJson(e)).toList();
          userrating.forEach((element) {
            // newRatings.addAll({"${element.globalBookEditionId}":element});
            newRatings[element.globalBookEditionId!]= element;
          });
          print(newRatings.toString());

          allBooks.forEach((book){
            book.userRatingModel = newRatings[book.globalBookEditionId!];
            // userRatingBook[book.globalBookEditionId]=0;
          });

        }

        allBooks = allBooks.toSet().toList();

        allBooksafter = allBooks;
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



  ////////////////////////

  createUpdateRating(
      dynamic global_book_edition_id,
      dynamic title,
      dynamic description,
      dynamic rating
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
      'spoiler': 0
    };
    SuccessfullyRating ratingbookK = await ratingApi.createUpdateRating(data,token);
    debugPrint("get02");
    // debugPrint(ratingbookK.toString());
    if(ratingbookK.message != null){
      if(ratingbookK.message == 500){
        emit(RatingNoTokenState());
      }
      else{
        Map<int,dynamic> newRatingsadded = {};
        userRatingModel = UserRatingModel.fromJson(ratingbookK.userRatingModel);
        debugPrint("HHHH");
        int id = userRatingModel.globalBookEditionId! ;
        newRatingsadded[id] = userRatingModel;
        newRatings.addAll(newRatingsadded);
        debugPrint(userRatingModel.globalBookEditionId.toString());
        debugPrint(this.allBooksafter.length.toString());
        if(allBooks.isNotEmpty){
          // allBooks.forEach((book) {
          //   print("LLL11");
          //   print(userRatingModel.globalBookEditionId);
          //   book.userRatingModel = newRatingsadded[book.globalBookEditionId];
          //   // if(book.userRatingModel!.globalBookEditionId == userRatingModel.globalBookEditionId){
          //   //   print("LLL22");
          //   //   allBooks[int.parse(userRatingModel.globalBookEditionId)].userRatingModel = userRatingModel;
          //   //   addRating = true;
          //   // }
          //   // if(addRating == false){
          //   //   print("LLL33");
          //   //   book.userRatingModel = ratingbookK.userRatingModel[book.globalBookEditionId];
          //   // }
          // });
          print("LLL");
          allBooks.forEach((book){
            print("KKKKMMMMMM");
            book.userRatingModel = newRatings[book.globalBookEditionId];
          });

        }

        emit(RatingCULoadedState(message: ratingbookK.message,books: allBooks));
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