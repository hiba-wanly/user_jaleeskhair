import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:userjaleeskhair/unit/unit.dart';

class RatingPage extends StatefulWidget {
  late String name;
  late String date;
  late int num;
  late double stars;
  late String image;

  RatingPage(
      {required this.image,
      required this.name,
      required this.date,
      required this.num,
      required this.stars});

  // const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState(
      image: this.image,
      name: this.name,
      date: this.date,
      num: this.num,
      stars: this.stars);
}

class _RatingPageState extends State<RatingPage> {
  late String name;
  late String date;
  late int num;
  late double stars;
  late String image;

  _RatingPageState(
      {required this.image,
      required this.name,
      required this.date,
      required this.num,
      required this.stars});

  double h = 0;
  double w = 0;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(h * 0.09),
      //   child: Container(
      //     decoration: BoxDecoration(
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.black.withOpacity(0.3),
      //           spreadRadius: 6,
      //           blurRadius: 6,
      //           offset: Offset(0, -4),
      //         ),
      //       ],
      //     ),
      //     child: AppBar(
      //       title: Center(
      //         child: Padding(
      //           padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.001),
      //           child: Text(
      //             name,
      //             style: TextStyle(
      //                 fontFamily: Almarai,
      //                 fontSize: w * 0.05,
      //                 color: Colors.black),
      //           ),
      //         ),
      //       ),
      //       centerTitle: true,
      //       backgroundColor: appbarcolor,
      //       automaticallyImplyLeading: false,
      //     ),
      //   ),
      // ),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: <Widget>[
        //   IconButton(onPressed:(){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back)),
        // ],
        leading: Row(
          children: [
            IconButton(onPressed:(){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back,color: Colors.black,size: 25,)),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Hero(
        tag: name,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.only(
              //   top: h * 0.1
              // ),
              height: h * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, boxShadow: kElevationToShadow[4],
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(image),),
              ),

            ),
            SizedBox(
              height: h * 0.025,
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,right: w*0.05),
              child: Row(
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
                        fontSize: w * 0.04,
                        color: Colors.black),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: h * 0.015,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.05),
                child: RatingBarIndicator(
                    rating: stars,
                    itemCount: 5,
                    itemSize: w * 0.05,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    )),
              ),
            ),



            SizedBox(
              height: h * 0.02,
            ),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
