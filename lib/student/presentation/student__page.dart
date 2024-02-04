import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userjaleeskhair/login/bloc/cubit_login.dart';
import 'package:userjaleeskhair/login/bloc/state_login.dart';
import 'package:userjaleeskhair/login/datalayer/login_model.dart';
import 'package:userjaleeskhair/login/datalayer/store_user.dart';
import 'package:userjaleeskhair/login/presentation/login.dart';
import 'package:userjaleeskhair/login/server/login_server.dart';
import 'package:userjaleeskhair/student/bloc/cubit_info.dart';
import 'package:userjaleeskhair/student/bloc/state_info.dart';
import 'package:userjaleeskhair/student/datalayer/book_model.dart';
import 'package:userjaleeskhair/student/datalayer/user_model.dart';
import 'package:userjaleeskhair/mmm.dart';
import 'package:userjaleeskhair/student/presentation/rating_page.dart';
import 'package:userjaleeskhair/student/rating_bloc/rating_cubit.dart';
import 'package:userjaleeskhair/student/rating_bloc/rating_state.dart';
import 'package:userjaleeskhair/unit/unit.dart';
import 'package:userjaleeskhair/unit/widgets.dart';

class StudentPage extends StatefulWidget {
  // late LoginModel userAccount;
  // late String name;
  // late String token;
  const StudentPage({Key? key}) : super(key: key);
  // StudentPage(
  //     {
  //     // required this.userAccount
  //     required this.name,
  //     required this.token});
  @override
  State<StudentPage> createState() => _StudentPageState();
      // userAccount: this.userAccount
      // name: this.name,
      // token: this.token);
}

class _StudentPageState extends State<StudentPage> {
  // late LoginModel userAccount;
  // late String name;
  // late String token;
  // _StudentPageState(
  //     {
  //     // required this.userAccount
  //     required this.name,
  //     required this.token});

  final GlobalKey<ScaffoldState> _sKey = GlobalKey();

  int selectedPos = 1;

  List<Books> books = [];

  Map<int, dynamic> uniqueBooksCounter = {};

  Map<int, String> uniqueBooksDates = {};

  late UserAccountInfo userAccountInfo;
  double bottomNavBarHeight = 0;
  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.next_plan_outlined,
      "متأخرة",
      Colors.red,
      labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: Almarai,
      ),
    ),
    TabItem(
      Icons.home,
      "حالية",
      Colors.blue,
      labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: Almarai,
      ),
    ),
    TabItem(
      Icons.next_plan_outlined,
      "سابقة",
      Colors.green,
      labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: Almarai,
      ),
    ),
  ]);
  late CircularBottomNavigationController _navigationController;

  List<Users> user = [];





  @override
  void initState() {
    super.initState();

    _navigationController = CircularBottomNavigationController(selectedPos);
    debugPrint("MMMM");
    BlocProvider.of<InfoCubit>(context).GetInfo(
        // userAccount.user.username, userAccount.token
        // name,
        // token
    );
  }

  double h = 0;
  double w = 0;
  String username = "";

  AuthApi  authApi = AuthApi();

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    bottomNavBarHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _sKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(h * 0.09),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 6,
                blurRadius: 6,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: AppBar(
              title: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.001),
                  child: Text(
                    username,
                    style: TextStyle(
                        fontFamily: Almarai,
                        fontSize: w * 0.05,
                        color: Colors.black),
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: appbarcolor,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  padding: EdgeInsets.only(top: h * 0.02),
                  onPressed: () {
                    _sKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: w * 0.06,
                  ),
                ),
              ],
              leading: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      padding: EdgeInsets.only(top: h * 0.02, left: w * 0.02),
                      onPressed: () {},
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.black,
                        size: w * 0.06,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      padding: EdgeInsets.only(top: h * 0.02, left: w * 0.02),
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_alert,
                        color: Colors.black,
                        size: w * 0.06,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
      body: Stack(
        children: [
          BlocConsumer<InfoCubit, InfoState>(
            listener: (context, state) {
              if (state is RatingCULoadedState){
                print("jijijijijiji");
                this.books = state.books;
              }
              if (state is InfoLoadedState) {
                debugPrint("1111");
                setState(() {
                  this.userAccountInfo = state.infomodel;
                  this.books = state.books;
                  this.uniqueBooksDates = state.uniqueBookDate;
                  this.uniqueBooksCounter = state.uniqueBookCounter;
                  this.username = userAccountInfo.userName;
                  this.user = state.user;
                });
              }
              if (state is InfoLoadedState22) {
                debugPrint("2222");
                this.userAccountInfo = state.infomodel;
                this.username = userAccountInfo.userName;
                this.user = state.user;
              }
              if (state is NoTokenState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is InfoLoadedState) {
                debugPrint("3333");
                return Stack(
                  children: <Widget>[
                    if (selectedPos == 0)
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(
                            userAccountInfo.lateBorrows, false, 0),
                      )
                    else if (selectedPos == 1)
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(
                            userAccountInfo.currentBorrows, false, 1),
                      )
                    else
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(books, true, 2),
                      ),
                  ],
                );
              }
              else if (state is InfoLoadedErrorState) {
                debugPrint("4444");
                return Stack(
                  children: <Widget>[
                    Center(
                        child: Text(
                      state.message,
                      style:
                          TextStyle(fontFamily: Almarai, fontSize: w * 0.055),
                    )),
                  ],
                );
              }
              else if (state is InfoLoadedState22) {
                debugPrint("5555");
                return Stack(
                  children: <Widget>[
                    if (selectedPos == 0)
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(
                            userAccountInfo.lateBorrows, false, 0),
                      )
                    else if (selectedPos == 1)
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(
                            userAccountInfo.currentBorrows, false, 1),
                      )
                    else
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(
                            userAccountInfo.returnedBorrows, false, 2),
                      ),
                  ],
                );
              } 
              else if (state is RatingCULoadedState)
              {
                debugPrint("3333");
                return Stack(
                  children: <Widget>[
                    if (selectedPos == 0)
                      Padding(
                        padding:
                        EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(
                            userAccountInfo.lateBorrows, false, 0),
                      )
                    else if (selectedPos == 1)
                      Padding(
                        padding:
                        EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(
                            userAccountInfo.currentBorrows, false, 1),
                      )
                    else
                      Padding(
                        padding:
                        EdgeInsets.only(bottom: bottomNavBarHeight * 0.04),
                        child: bodyContainer(books, true, 2),
                      ),
                  ],
                );
              }
              else {
                debugPrint("6666");
                return Stack(
                  children: <Widget>[
                    Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    )),
                  ],
                );
              }
            },
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav()),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: h * 0.15,
              child: DrawerHeader(
                padding: EdgeInsets.only(top: h * 0.05),
                decoration: BoxDecoration(
                  color: primarycolor,
                ),
                child: Text(
                  username,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: Almarai, fontSize: w * 0.055),
                ),
              ),
            ),
            ExpansionTile(
              title: Text(
                "المستخدمون",
                style: TextStyle(
                    fontFamily: Almarai,
                    fontSize: w * 0.04,
                    color: Colors.black),
              ),
              leading: Icon(Icons.person),
              childrenPadding: EdgeInsets.only(left: w * 0.1),
              children: [
                for (int i = 0; i < user.length; i++)
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      // prefs.remove("save_token");
                      // prefs.remove("save_name");
                      prefs.setString("save_token", user[i].token!);
                      prefs.setString("save_name", user[i].username!);
                      authApi.storeToken(user[i].token!);
                      authApi.storeUserName(user[i].username!);
                      BlocProvider.of<InfoCubit>(context).GetInfo(
                          // userAccount.user.username, userAccount.token
                          // user[i].username,
                          // user[i].token
                      );
                    },
                    child: Container(
                      child: ListTile(
                        title: Text(
                          user[i].first_name! + " " + user[i].last_name!,
                          style: TextStyle(
                              fontFamily: Almarai,
                              fontSize: w * 0.035,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text(
                "إضافة حساب جديد",
                style: TextStyle(
                    fontFamily: Almarai,
                    fontSize: w * 0.04,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
            BlocProvider(
              create: (context) => AuthCubit(AuthInitialState()),
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is LogoutLoaddedState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                  FlushBar(state.message, h, context);
                }
                if (state is LogoutState) {
                  BlocProvider.of<InfoCubit>(context).GetInfo(
                      // userAccount.user.username, userAccount.token
                      // state.token,
                      // state.username
                  );
                  // BlocProvider(
                  //   create: (context) => InfoCubit(InfoInitialState()),
                  //   child: StudentPage(token: state.token ,name: state.username,),
                  // );
                }
              }, builder: (context, state) {
                return ListTile(
                  leading: Icon(Icons.logout),
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).Logout();
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyContainer(List<Books>? books, bool bb, int num) {
    print("11111111111");
    // print(books![0].localBookName);
    return books!.isEmpty
        ? Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (num == 0)
                  Text(
                    "لا يوجد كتب متأخرة ",
                    style: TextStyle(
                        fontFamily: Almarai,
                        fontSize: w * 0.05,
                        color: Colors.black),
                  ),
                if (num == 1)
                  Text(
                    "لا يوجد كتب مستعارة حاليا ",
                    style: TextStyle(
                        fontFamily: Almarai,
                        fontSize: w * 0.05,
                        color: Colors.black),
                  ),
                if (num == 2)
                  Text(
                    "لا يوجد كتب سابقة ",
                    style: TextStyle(
                        fontFamily: Almarai,
                        fontSize: w * 0.05,
                        color: Colors.black),
                  ),
              ],
            ),
          )
        : Container(
          color: Colors.white,
          child: GestureDetector(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.only(
                          left: h * 0.02, right: h * 0.02, top: h * 0.035),
                      itemCount: books.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          Container(
                            height: h * 0.13,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: kElevationToShadow[4]),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Stack(children: [
                                      // CachedNetworkImage(
                                      //     imageUrl: 'https://jaleeskhair.com/img/books/${books[index].globalBookEditionId}_front_face.jpg',
                                      //     placeholder:( context,url) =>  new CircularProgressIndicator(backgroundColor: Colors.white,),
                                      //     errorWidget: (context,url, error) => Icon(Icons.person,color: Colors.grey,size: 35,),
                                      //     width: double.infinity,
                                      //     height:
                                      //     MediaQuery.of(context).size.height * 0.13,
                                      //     fit: BoxFit.fill,
                                      // ),
                                      FadeInImage(
                                        image: NetworkImage(
                                          'https://jaleeskhair.com/img/books/${books[index].globalBookEditionId}_front_face.jpg',
                                        ),
                                        placeholder: const AssetImage(
                                            "images/bookwithoutback.png"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'images/bookwithoutback.png',
                                              fit: BoxFit.fitWidth);
                                        },
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      bb
                                          ? Align(
                                              alignment: Alignment.topRight,
                                              child: SizedBox(
                                                child: CircleAvatar(
                                                    radius: 10.0,
                                                    backgroundColor: Colors.green,
                                                    child: Text(
                                                      uniqueBooksCounter[
                                                              books[index]
                                                                  .localBookId]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily: Almarai,
                                                          fontSize: w * 0.03,
                                                          color: Colors.black),
                                                    )),
                                              ),
                                            )
                                          : Text(""),
                                    ]),
                                  ),
                                  VerticalDivider(
                                    color: Colors.grey[200],
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    width: w * 0.05,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            books[index].localBookName.toString(),
                                            style: TextStyle(
                                                fontFamily: Almarai,
                                                fontSize: w * 0.04,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            bb
                                                ? Text(
                                                    uniqueBooksDates[books[index]
                                                            .localBookId]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: Almarai,
                                                        fontSize: w * 0.03,
                                                        color: Colors.black),
                                                  )
                                                : Text(
                                                    books[index]
                                                        .borrowStartDate
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: Almarai,
                                                        fontSize: w * 0.03,
                                                        color: Colors.black),
                                                  ),
                                            num == 2 ?  GestureDetector(
                                              onTap: (){
                                                print("ll");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute<RatingPage>(
                                                    builder: (context2) =>
                                                      BlocProvider<InfoCubit>.value(
                                                          value: BlocProvider.of<InfoCubit>(context),
                                                          // create: ( context) => RatingCubit(RatingInitialState()),
                                                          child:
                                                          RatingPage(
                                                            image: 'https://jaleeskhair.com/img/books/${books[index].globalBookEditionId}_front_face.jpg',
                                                            name: books[index].localBookName,
                                                            date: uniqueBooksDates[books[index]
                                                                .localBookId].toString(),
                                                            num: uniqueBooksCounter[
                                                            books[index]
                                                                .localBookId],
                                                            stars: 0,
                                                            book_id: books[index].localBookId,
                                                            global_book_edition_id: books[index].globalBookEditionId,
                                                            userRatingModel: books[index].userRatingModel,

                                                          )
                                                      ),


                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:  EdgeInsets.only(left: w*0.05),
                                                child: Hero(
                                                  tag: books[index].localBookId,
                                                  child: RatingBarIndicator(

                                                    textDirection: TextDirection.ltr,
                                                      rating: books[index].userRatingModel != null ? books[index].userRatingModel!.rating!.toDouble() : 0.0,
                                                      itemCount: 5,
                                                      itemSize: w * 0.06,
                                                      itemBuilder: (context, _) => const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                  ),
                                                ),
                                              ),
                                            ) : Container(),

                                          ],
                                        )
                                        // bb ?
                                        // Text(
                                        //   uniqueBooksCounter[books[index].localBookId]
                                        //       .toString(),
                                        //   style: TextStyle(
                                        //       fontFamily: Almarai,
                                        //       fontSize: w * 0.03,
                                        //       color: Colors.black),
                                        // ):
                                        // Text(
                                        //   "",
                                        //   style: TextStyle(
                                        //       fontFamily: Almarai,
                                        //       fontSize: w * 0.03,
                                        //       color: Colors.black),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                  ],
                ),
              ),
              onTap: () {
                // if (_navigationController.value == tabItems.length - 1) {
                //   _navigationController.value = 0;
                // } else {
                //   _navigationController.value = _navigationController.value! + 1;
                // }
              },
            ),
        );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight * 0.07,
      // use either barBackgroundColor or barBackgroundGradient to have a gradient on bar background
      barBackgroundColor: Colors.white,
      // barBackgroundGradient: LinearGradient(
      //   begin: Alignment.bottomCenter,
      //   end: Alignment.topCenter,
      //   colors: [
      //     Colors.blue,
      //     Colors.red,
      //   ],
      // ),
      backgroundBoxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
          print(_navigationController.value);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
