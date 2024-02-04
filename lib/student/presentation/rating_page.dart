import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:userjaleeskhair/student/bloc/cubit_info.dart';
import 'package:userjaleeskhair/student/bloc/state_info.dart';
import 'package:userjaleeskhair/student/datalayer/user_rating_model.dart';
import 'package:userjaleeskhair/student/presentation/student__page.dart';
import 'package:userjaleeskhair/student/rating_bloc/rating_cubit.dart';
import 'package:userjaleeskhair/student/rating_bloc/rating_state.dart';
import 'package:userjaleeskhair/unit/unit.dart';
import 'package:userjaleeskhair/unit/widgets.dart';

class RatingPage extends StatefulWidget {
  late String name;
  late String date;
  late int num;
  late double stars;
  late String image;
  late int book_id;
  late int global_book_edition_id;
  UserRatingModel? userRatingModel;

  RatingPage(
      {required this.image,
      required this.name,
      required this.date,
      required this.num,
      required this.stars,
      required this.book_id,
      required this.global_book_edition_id,
      this.userRatingModel});

  // const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState(
      image: this.image,
      name: this.name,
      date: this.date,
      num: this.num,
      stars: this.stars,
      book_id: this.book_id,
      global_book_edition_id: this.global_book_edition_id,
      userRatingModel: this.userRatingModel);
}

class _RatingPageState extends State<RatingPage> {
  late String name;
  late String date;
  late int num;
  late double stars;
  late String image;
  late int book_id;
  late int global_book_edition_id;
  UserRatingModel? userRatingModel;

  _RatingPageState(
      {required this.image,
      required this.name,
      required this.date,
      required this.num,
      required this.stars,
      required this.book_id,
      required this.global_book_edition_id,
      this.userRatingModel});

  double h = 0;
  double w = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool star = false;


late double ratingstar = userRatingModel != null ? userRatingModel!.rating.toDouble() : 0.0;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    // ratingstar = userRatingModel != null ? userRatingModel!.rating : 0.0;
    return Hero(
      tag: book_id,
      child: Form(
        key: formkey,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 25,
                    )),
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: h * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: kElevationToShadow[4],
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: NetworkImage(image),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05,bottom: h*0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date.toString(),
                              style: TextStyle(
                                  fontFamily: Almarai,
                                  fontSize: w * 0.035,
                                  color: Colors.black),
                            ),
                            Text(
                              name.toString(),
                              style: TextStyle(
                                  fontFamily: Almarai,
                                  fontSize: w * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Text(
                          " * أعط تقييما للكتاب  ",
                          style: TextStyle(
                            fontFamily: Almarai,
                            fontSize:w * 0.04,
                            color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RatingBar.builder(
                            initialRating: userRatingModel != null
                                ? userRatingModel!.rating!.toDouble()
                                : 0.0,
                            // minRating: 1,
                            // direction: Axis.horizontal,
                            textDirection: TextDirection.ltr,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: w * 0.1,
                            itemPadding:
                            EdgeInsets.symmetric(horizontal: w * 0.015),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              this.ratingstar = rating;
                             if (ratingstar != 0.0 ){
                               debugPrint("here star");
                               setState(() {
                                 debugPrint("false");
                                 star = false;
                               });
                             }
                              print(ratingstar);
                            },
                          ),
                        ),
                        star ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            "يجب ادخال عدد النجوم",
                              style: TextStyle(
                                  fontFamily: Almarai,
                                  fontSize:w * 0.03,
                                  color: Colors.red
                            ),
                          ),
                        ) :
                        SizedBox(
                          height: h * 0.02,
                        ),
                        boxController(
                            titleController,
                            userRatingModel != null
                                ? userRatingModel!.title
                                : "",
                            TextInputType.text,
                            h,
                            w,
                            userRatingModel != null ? 1 : 0,
                            1," * عنوان التقييم  "),
                        boxController(
                            descriptionController,
                            userRatingModel != null
                                ? userRatingModel!.description
                                : "",
                            TextInputType.text,
                            h,
                            w,
                            userRatingModel != null ? 1 : 0,
                            0,"التقييم التفصيلي"),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        // BlocProvider(
                        //   create: (context) => InfoCubit(RatingInitialState()),
                        //   child:
                          BlocConsumer<InfoCubit, InfoState>(
                              listener: (context, state) {
                            if (state is RatingCULoadedState) {
                              Navigator.pop(context);
                              FlushBar(state.message, h, context);
                              // Timer(const Duration(milliseconds: 5), (){
                              //   Navigator.pop(context);
                              //   // Navigator.push(
                              //   //   context,
                              //   //   MaterialPageRoute(
                              //   //     builder: (context) => BlocProvider(create: (BuildContext context) => InfoCubit(InfoInitialState()),
                              //   //       child: StudentPage(
                              //   //         name: state.loginModel.user.username,
                              //   //         token: state.loginModel.token
                              //   //         ,),),
                              //   //   ),
                              //   // );
                              // });
                            }
                            if (state is RatingLoadedErrorState) {
                              FlushBar(state.message, h, context);
                            }
                          }, builder: (context, state) {
                            if (state is RatingLoadingState) {
                              return Container(
                                height: h * 0.05,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  gradient: LinearGradient(
                                    colors: [primarycolor, Colors.blue],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: h * 0.005,
                                      bottom: h * 0.005,
                                      left: h * 0.009,
                                      right: h * 0.009,
                                    ),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }
                            else {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          formkey = GlobalKey<FormState>();
                                          titleController = TextEditingController();
                                          descriptionController = TextEditingController();
                                          ratingstar = userRatingModel != null ? userRatingModel!.rating.toDouble() : 0.0;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: h * 0.05,
                                        width: double.infinity,
                                        // margin: EdgeInsets.only(left: w*0.05,right: w*0.05),
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          gradient: LinearGradient(
                                            colors: [primarycolor, Colors.blue],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                          ),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),topLeft: Radius.circular(25)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "إلغاء",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: w * 0.05,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: Almarai),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 0.5,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        print(this.ratingstar);
                                        if(ratingstar == 0.0 && star == false){
                                          setState(() {
                                            debugPrint("true");
                                            star = true;
                                          });
                                        } else {
                                          if (formkey.currentState!.validate()) {
                                            BlocProvider.of<InfoCubit>(context)
                                                .createUpdateRating(
                                                global_book_edition_id,
                                                titleController.text != null
                                                    ? titleController.text
                                                    : userRatingModel!.title,
                                                descriptionController.text != null
                                                    ? descriptionController.text
                                                    : userRatingModel!.description,
                                                ratingstar /*!= null ? ratingstar : userRatingModel!.rating*/
                                            );
                                          }
                                        }

                                      },
                                      child: Container(
                                        height: h * 0.05,
                                        width: double.infinity,
                                        // margin: EdgeInsets.only(left: w*0.05,right: w*0.05),
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          gradient: LinearGradient(
                                            colors: [primarycolor, Colors.blue],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                          ),
                                          borderRadius:BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            userRatingModel == null
                                                ? "إضافة"
                                                : "تعديل",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: w * 0.05,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: Almarai),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              );
                            }
                          }),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
