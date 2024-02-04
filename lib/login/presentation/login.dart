import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userjaleeskhair/student/bloc/cubit_info.dart';
import 'package:userjaleeskhair/student/bloc/state_info.dart';

import '../../student/presentation/student__page.dart';
import '../../unit/unit.dart';
import '../../unit/widgets.dart';
import '../bloc/cubit_login.dart';
import '../bloc/state_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  bool ispassword = true;
  var formkey = GlobalKey<FormState>();
  double h = 0;
  double w = 0;

  @override
  Widget build(BuildContext context) {
    this.h = MediaQuery
        .of(context)
        .size
        .height;
    this.w = MediaQuery
        .of(context)
        .size
        .width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: formkey,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/bg.jpg"),
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,
                        right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.09,
                          decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.015),
                              topRight: Radius.circular(
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.015),
                            ),
                            image: DecorationImage(
                              image: AssetImage("images/logo.png"),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.01,),
                        Text(
                          'أهلاً بعودتك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * 0.07,
                            fontFamily: Almarai,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05,
                              right: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05,
                              top: 0),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          // height: MediaQuery.of(context).size.height * 0.22,//////
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _box(
                                  userNameController,
                                  ' اسم المستخدم *',
                                  TextInputType.text),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.02,
                              ),
                              _box(passwordcontroller, 'كلمة المرور *',
                                  TextInputType.visiblePassword),

                            ],
                          ),
                        ),
                        _loginButton(),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.015)),
                        border: Border.all(color: Colors.grey, width: 1),
                        boxShadow: kElevationToShadow[2]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),);
  }

  Widget _box(TextEditingController controller, String label,
      TextInputType textInputType) =>
      Container(
        margin:
        EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.015),
        child: TextFormField(
          textDirection: TextDirection.ltr,
          controller: controller,
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery
                .of(context)
                .size
                .height * 0.017,
            fontWeight: FontWeight.w500,
            fontFamily: Almarai,
          ),
          cursorColor: primarycolor,
          keyboardType: textInputType,
          onFieldSubmitted: (val) {
            debugPrint(val);
          },
          obscureText: controller == passwordcontroller ? ispassword : false,
          validator: (value) {
            if (controller == userNameController) {
              if (value!.isEmpty) {
                return ' اسم المستخدم مطلوب';
              }
              return null;
            }
            if (controller == passwordcontroller) {
              if (value!.isEmpty) {
                return 'login.requiredPassword';
              }
              return null;
            }
          },
          maxLines: 1,
          decoration: InputDecoration(
            // hintTextDirection: TextDirection.rtl,

            floatingLabelStyle: TextStyle(color: primarycolor),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: primarycolor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primarycolor),
            ),
            label: Text(label,
              style: TextStyle(
                fontFamily: Almarai,
              ),),
            contentPadding: EdgeInsets.only(bottom: 0),
              suffixIcon: controller == passwordcontroller
                  ? IconButton(
                  onPressed: () {
                    setState(() {
                      ispassword = !ispassword;
                    });
                  },
                  icon: Icon(
                    ispassword ? Icons.visibility_off : Icons.visibility,
                    size: MediaQuery.of(context).size.height * 0.02,
                  ))
                  : null
          ),
        ),
      );

  Widget _loginButton() =>
      BlocProvider(
        create: (context) => AuthCubit(AuthInitialState()),
        child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadedState) {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    //     BlocProvider(create: (BuildContext context) => InfoCubit(InfoInitialState()),
                    // child:
                    StudentPage(
                      // userAccount: state.loginModel
                      // name: state.loginModel.user.username,
                      // token: state.loginModel.token
                      )
                      // ,),
                  ),
                );
              }
              if (state is AuthLoadedErrorState) {
                FlushBar(state.message, h, context);
              }
            }, builder: (context, state) {
          if (state is AuthLoadingState) {
            return Container(
              margin: EdgeInsets.only(
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.05,
                right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.05,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .width * 0.05,
                top: MediaQuery
                    .of(context)
                    .size
                    .width * 0.09,
              ),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primarycolor,
                  borderRadius: BorderRadius.circular(
                      MediaQuery
                          .of(context)
                          .size
                          .width * 0.015),
                  boxShadow: kElevationToShadow[2]),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.005,
                    bottom: MediaQuery
                        .of(context)
                        .size
                        .height * 0.005,
                    left: MediaQuery
                        .of(context)
                        .size
                        .height * 0.009,
                    right: MediaQuery
                        .of(context)
                        .size
                        .height * 0.009,

                  ),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  BlocProvider.of<AuthCubit>(context).Login(
                      userNameController.text,passwordcontroller.text);
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05,
                  right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05,
                  bottom: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05,
                  top: MediaQuery
                      .of(context)
                      .size
                      .width * 0.09,
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(
                        MediaQuery
                            .of(context)
                            .size
                            .width * 0.015),
                    boxShadow: kElevationToShadow[2]),
                child: Center(
                  child: Text(
                    ' دخول ',
                    style: TextStyle(
                      fontFamily: Almarai,
                      color: Colors.black,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }
        }),
      );
}

