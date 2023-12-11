import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userjaleeskhair/login/presentation/login.dart';
import 'package:userjaleeskhair/student/bloc/cubit_info.dart';
import 'package:userjaleeskhair/student/bloc/state_info.dart';
import 'package:userjaleeskhair/student/presentation/student__page.dart';
import 'package:userjaleeskhair/unit/unit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({Key? key}) : super(key: key);

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {

  String? token;
  String? name;
  bool initial = true;

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if(initial == true){
      SharedPreferences.getInstance().then((shard){
        setState(() {
          initial = false;
          token = shard.getString("save_token");
          name = shard.getString("save_name");
          // debugPrint("ttttttt"+token!);
          debugPrint('***********');
        });
      });
      // return CircularProgressIndicator();
      return Scaffold(
        body: Stack(
          children: [
            Container(
              width: w,
              height: h,
              color: Colors.white,
            ),
            Center(
              child: Text(
                "",
                // "اهلا بعودتك",
                style: const TextStyle(
                  color: primarycolor,
                ),
              ),
            )
          ],
        ),
      );
    }else {
      if(token == null){
        return LoginScreen();
      } else {
        // return LoginScreen();
        return BlocProvider(
          create: (context) => InfoCubit(InfoInitialState()),
          child: StudentPage(token: token! ,name: name!,),
        );
      }
    }

  }
}
