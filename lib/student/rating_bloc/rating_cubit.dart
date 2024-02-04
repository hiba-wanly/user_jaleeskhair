// import 'dart:js';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:userjaleeskhair/login/server/login_server.dart';
// import 'package:userjaleeskhair/student/bloc/cubit_info.dart';
// import 'package:userjaleeskhair/student/bloc/state_info.dart';
// import 'package:userjaleeskhair/student/datalayer/rating_model.dart';
// import 'package:userjaleeskhair/student/datalayer/successfully_rating.dart';
// import 'package:userjaleeskhair/student/datalayer/user_rating_model.dart';
// import 'package:userjaleeskhair/student/presentation/student__page.dart';
// import 'package:userjaleeskhair/student/rating_bloc/rating_state.dart';
// import 'package:userjaleeskhair/student/server/info_server.dart';
// import 'package:userjaleeskhair/student/server/rating_server.dart';
//
// class RatingCubit extends Cubit<RatingState>{
//   RatingCubit(RatingState initialState) : super(initialState);
//
//   static RatingCubit get(context) => BlocProvider.of(context);
//
//   RatingApi ratingApi = RatingApi();
//
//   AuthApi authApi = AuthApi();
//
//   RatingBook ratingBook = RatingBook();
//
//   late UserRatingModel userRatingModel;
//
//   // var  infoCubit = InfoCubit.get(context).allBooks;
//
//   bool addRating = false ;
//
//   // StudentPage ss = StudentPage();
//
//   createUpdateRating(
//       dynamic global_book_edition_id,
//       dynamic title,
//       dynamic description,
//       dynamic rating
//       ) async
//   {
//     debugPrint("get01");
//     emit(RatingLoadingState());
//     String? token = await authApi.getToken();
//     debugPrint(token);
//     Map<String , dynamic> data = {
//       'global_book_edition_id': global_book_edition_id,
//       'title': title,
//       'description': description,
//       'rating': rating,
//       'public': 0,
//       'spoiler': 0
//     };
//     SuccessfullyRating ratingbookK = await ratingApi.createUpdateRating(data,token);
//     debugPrint("get02");
//     // debugPrint(ratingbookK.toString());
//     if(ratingbookK.message != null){
//       if(ratingbookK.message == 500){
//         emit(RatingNoTokenState());
//       }
//       else{
//          userRatingModel = UserRatingModel.fromJson(ratingbookK.userRatingModel);
//          debugPrint("HHHH");
//          debugPrint(userRatingModel.globalBookEditionId.toString());
//          debugPrint(infoCubit.length.toString());
//          if(infoCubit != null){
//            infoCubit.forEach((book) {
//              print("LLL11");
//              print(userRatingModel.globalBookEditionId);
//                if(book.userRatingModel!.globalBookEditionId == userRatingModel.globalBookEditionId){
//                  print("LLL22");
//                infoCubit[int.parse(userRatingModel.globalBookEditionId)].userRatingModel = userRatingModel;
//                addRating = true;
//              }
//              if(addRating == false){
//                print("LLL33");
//                book.userRatingModel = ratingbookK.userRatingModel[book.globalBookEditionId];
//              }
//            });
//            print("LLL");
//            infoCubit.forEach((book){
//              print("KKKKMMMMMM");
//              print(book.globalBookEditionId);
//            });
//
//          }
//         emit(RatingCULoadedState(message: ratingbookK.message));
//       }
//     }
//     else {
//       debugPrint("get0006");
//       emit(RatingLoadedErrorState(message: 'لا يمكن اتمام العملية'));
//     }
//   }
//
//
//   getUserBookRating(dynamic bookId) async
//   {
//     emit(RatingLoadingState());
//     debugPrint("log3");
//     String? token = await authApi.getToken();
//     debugPrint(token);
//     final response = await ratingApi.userBookRating(bookId,token);
//
//     if(response != null){
//       if(response == "User not found"){
//         emit(RatingLoadedErrorState(message: response));
//       }
//       if(response == 500){
//         emit(RatingNoTokenState());
//       }
//       else {
//         debugPrint("log4");
//         this.ratingBook =  RatingBook.fromJson(response);
//         emit(RatingGetLoadedState(ratingBook: ratingBook));
//       }
//     }
//     else{
//       emit(RatingLoadedErrorState(message: "لا يمكن اتمام العملية"));
//     }
//
//   }
//
//
// }