import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userjaleeskhair/unit/unit.dart';

Future FlushBar(String message, double h, BuildContext context) => Flushbar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      messageColor: Colors.black,
      messageSize: h * 0.02,
      message: message,
    ).show(context);

Widget boxController(
        TextEditingController controller,
        String? label,
        TextInputType textInputType,
        double h,
        double w,
        dynamic name,
        dynamic nn,
        String labeltext) =>
    Container(
      margin: EdgeInsets.only(top: h * 0.005,bottom: h*.02),
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
              labeltext,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.04,
                fontFamily: Almarai
              )
          ),
          SizedBox(height: h*0.01),
          Container(

            child: TextFormField(
              autofocus: false,
              textDirection: TextDirection.rtl,
              controller: controller,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w400,
                  fontFamily: Almarai),
              keyboardType: textInputType,
              onFieldSubmitted: (val) {
                print(val);
              },
              validator: (value) {
                if (value!.isEmpty && name == 0 && nn == 1) {
                  return 'الحقل إلزامي';
                }
              },
              // maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 3,
                  ),

                ),
                hintText: label,
                hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: Almarai
                ),


              ),
            ),
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
          ),
        ],
      ),
    );
