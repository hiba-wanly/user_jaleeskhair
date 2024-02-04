
import 'package:userjaleeskhair/login/datalayer/store_user.dart';
import 'package:userjaleeskhair/student/datalayer/book_model.dart';
import 'package:userjaleeskhair/student/datalayer/rating_model.dart';
import 'package:userjaleeskhair/student/datalayer/user_model.dart';

abstract class InfoState{}

class InfoInitialState extends InfoState{}

class InfoLoadingState extends InfoState{}

class InfoLoadedState extends InfoState{
  final UserAccountInfo infomodel;

  final List<Books> books;
  final Map<int,dynamic> uniqueBookCounter;
  final Map<int,String> uniqueBookDate;
  final List<Users> user ;

  InfoLoadedState( this.infomodel,this.books,this.uniqueBookCounter,this.uniqueBookDate,this.user);
}

class InfoLoadedState22 extends InfoState {
  final UserAccountInfo infomodel;
  final List<Users> user ;
  InfoLoadedState22(this.infomodel,this.user);
}
class InfoLoadedErrorState extends InfoState {
  final String message ;
  InfoLoadedErrorState({required this.message});
}

class NoTokenState extends InfoState {}



class RatingInitialState extends InfoState{}

class RatingLoadingState extends InfoState{}

class RatingCULoadingState extends InfoState{
  final String message ;
  RatingCULoadingState({required this.message});
}

class RatingCULoadedState extends InfoState {
  final String message ;
  final List<Books> books;
  RatingCULoadedState({required this.message,required this.books});
}

class RatingGetLoadedState extends InfoState {
  final RatingBook ratingBook;
  RatingGetLoadedState({required this.ratingBook});
}

class RatingLoadedErrorState extends InfoState {
  final String message ;
  RatingLoadedErrorState({required this.message});
}

class RatingNoTokenState extends InfoState {}