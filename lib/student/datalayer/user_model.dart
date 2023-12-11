import 'package:userjaleeskhair/student/datalayer/book_model.dart';

class UserAccountInfo {
  late dynamic userId;
  late dynamic userName;
  late dynamic library;
  late dynamic userGrade;
  late dynamic userClass;
  late bool allowedToBorrow;
  late dynamic reason;
  late dynamic allowedToBorrowCount;
  late dynamic allBorrowsCount;
  late dynamic returnedBorrowsCount;
  late List<Books>? returnedBorrows;

  // late List<Books>? allBorrows;
  late dynamic currentBorrowsCount;
  late List<Books>? currentBorrows;
  late dynamic lateBorrowsCount;
  late List<Books>? lateBorrows;
  /////




  UserAccountInfo({
    required this.userId,
    required this.userName,
    required this.allowedToBorrow,
    required this.reason,
    required this.allowedToBorrowCount,
    required this.allBorrowsCount,
    // required this.allBorrows,
    required this.currentBorrowsCount,
    required this.currentBorrows,
    required this.lateBorrowsCount,
    required this.lateBorrows,
    required this.library,
    required this.userGrade,
    required this.userClass,
    required this.returnedBorrowsCount,
    required this.returnedBorrows
  });

  UserAccountInfo.fromJson(Map<String ,dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    allowedToBorrow = json['allowedToBorrow'];
    reason = json['reason'];
    allowedToBorrowCount = json['allowedToBorrowCount'];
    allBorrowsCount = json['allBorrowsCount'];
    // allBorrows = (json['allBorrows'] as List).map((e) => Books.fromJson(e)).toList();
    returnedBorrows = (json['returnedBorrows'] as List).map((e) => Books.fromJson(e)).toList();
    library = json['library'];
    userGrade = json['userGrade'];
    userClass = json['userClass'];
    returnedBorrowsCount = json['returnedBorrowsCount'];
    currentBorrowsCount = json['currentBorrowsCount'];
    currentBorrows = (json['currentBorrows'] as List).map((e) => Books.fromJson(e)).toList();
    lateBorrowsCount = json['lateBorrowsCount'];
    lateBorrows = (json['lateBorrows'] as List).map((e) => Books.fromJson(e)).toList();
  }

}

