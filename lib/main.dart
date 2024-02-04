import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userjaleeskhair/login/presentation/auth_login.dart';
import 'package:userjaleeskhair/login/presentation/login.dart';
import 'package:userjaleeskhair/student/bloc/cubit_info.dart';
import 'package:userjaleeskhair/student/bloc/state_info.dart';
import 'package:userjaleeskhair/student/presentation/student__page.dart';
import 'package:userjaleeskhair/unit/unit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoCubit(InfoInitialState()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textSelectionTheme: TextSelectionThemeData(selectionHandleColor: primarycolor),
        ),
        debugShowCheckedModeBanner: false,
        home:
        AuthLogin(),

        // LoginScreen(),
      ),
    );
  }
}
