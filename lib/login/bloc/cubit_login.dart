
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:userjaleeskhair/login/bloc/state_login.dart';
import 'package:userjaleeskhair/login/datalayer/login_model.dart';
import 'package:userjaleeskhair/login/datalayer/store_user.dart';
import 'package:userjaleeskhair/student/datalayer/user_model.dart';

import '../server/login_server.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit(AuthState initialState) : super(initialState);

  static AuthCubit get(context) => BlocProvider.of(context);

  AuthApi authApi = AuthApi();
  late LoginModel loginModel;

  Login(dynamic name,dynamic password) async {
    emit(AuthLoadingState());
    debugPrint("log3");
    Map<String , dynamic> data = {
      'username': name,
      'password': password
    };
    dynamic response = await authApi.Login(data);
    if(response != null){
      if(response == "error"){
        emit(AuthLoadedErrorState(message: "لا يمكن تسجيل الدخول"));
      }
      else {
      debugPrint("log4");
        this.loginModel = LoginModel.fromJson(response);
        if (loginModel.token != null) {
          debugPrint("1");
          Users user = Users(token: loginModel.token, username: loginModel.user.username,first_name: loginModel.user.first_name,last_name: loginModel.user.last_name);
          // addUserToList(user);
          // newUserToList(user);
          // List<Users> uu = await getUsers();
          // if(uu.isNotEmpty){
          //   debugPrint("2");
            newUserToList(user);
          //   // uu.forEach((element) {
          //   //   debugPrint("3");
          //   //   newUserToList(element);
          //   // });
          // }else{
          //   debugPrint("4");
          //   // addUserToList(user);
          // }


          // Users users = Users(token: loginModel.token, username: loginModel.user.username,first_name: loginModel.user.first_name,last_name: loginModel.user.last_name);
          // addUserToList(users);

          // SharedPreferences pref = await SharedPreferences.getInstance();
          //
          // List<String> userString = pref.getStringList('user') ?? [];
          // userString.clear();
          // pref.clear();
          debugPrint("KKKKKKKKK");
          emit(AuthLoadedState(loginModel: loginModel));
        }
        else {
          emit(AuthLoadedErrorState(message: "لا يمكن تسجيل الدخول"));
        }
      }
    }
    else{
      emit(AuthLoadedErrorState(message: "لا يمكن تسجيل الدخول"));
    }

  }

  addUserToList(Users user) async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> userString = pref.getStringList('user') ?? [];

    Map<String , dynamic> users =  user.usertojson();

    String usersItem = jsonEncode(users);

    debugPrint(usersItem);
    debugPrint("kkk");

    userString.add(usersItem);

    pref.setStringList('user',userString);

    debugPrint(userString.toString());
    debugPrint("lll");

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

  newUserToList(Users users)async{

    debugPrint("5");
    SharedPreferences pref = await SharedPreferences.getInstance();

    // pref.clear();

    List<String> userString = pref.getStringList('user') ?? [];

    List<String> newUsers = [];
    debugPrint("6");
    Map<String , dynamic> user1 =  users.usertojson();
    String usersItem = jsonEncode(user1);

    // List<String> aa = [];
    if(userString.isNotEmpty){
      debugPrint("7");

      userString.forEach((element) {

        Map<String,dynamic> json = jsonDecode(element);
        Users user2 = Users.fromJson(json);
        // aa.add(user1.username.toString());
        // if(users.username == user2.username){
        //   debugPrint("8");
        //   // continue;
        // }
        if(users.username != user2.username){
          debugPrint("9");
          // Users users = Users(token: loginModel.token, username: loginModel.user.username,first_name: loginModel.user.first_name,last_name: loginModel.user.last_name);
          // addUserToList(users);
          newUsers.add(element);
        }
      });

      newUsers.add(usersItem);

      debugPrint(newUsers.toString());
      debugPrint("11");
      pref.setStringList('user', newUsers);

      // pref.clear();


    }
    else {
      debugPrint("10");
      addUserToList(users);
    }
  }


  Logout()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("save_name");
    prefs.remove('save_name');
    prefs.remove('save_token');


    List<String> userString = prefs.getStringList('user') ?? [];

    List<String> newUsers = [];
    debugPrint("6");

    if(userString.isNotEmpty){
      debugPrint("7");
      userString.forEach((element) {

        Map<String,dynamic> json = jsonDecode(element);
        Users user2 = Users.fromJson(json);

        if(name != user2.username){
          debugPrint("9");
          newUsers.add(element);
        }
      });
      debugPrint(newUsers.toString());
      debugPrint("11");
      prefs.setStringList('user', newUsers);

    }

    List<String> userString22 = prefs.getStringList('user') ?? [];


    if(userString22.isEmpty){
      emit(LogoutLoaddedState(message: "logout"));
    }
    else if (userString22.isNotEmpty){
      Map<String,dynamic> json = jsonDecode(userString22.first);
      Users user2 = Users.fromJson(json);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("save_token", user2.token!);
      prefs.setString("save_name", user2.username!);
      emit(LogoutState(token: user2.token!,username: user2.username!));
    }


  }

}