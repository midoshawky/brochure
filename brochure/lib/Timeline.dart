import 'package:flutter/material.dart';
import 'Profile.dart';
import 'noGlow.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'userData.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Color mainColor = Color.fromRGBO(74, 176, 255, 1);
  List<userData> User = [];
  String ImgURL, UserName, getURL;

  double defaultScreenWidth = 400.0;
  double defaultScreenHeight = 810.0;
  ScreenUtil screenUtil = ScreenUtil.instance;

  GlobalKey<ScaffoldState> scaffKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    FetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.restoreSystemUIOverlays();
    return Scaffold(
      key: scaffKey,
      resizeToAvoidBottomPadding: false,
      drawer: customDrawer(),
      appBar: PreferredSize(
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: mainColor,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          scaffKey.currentState.openDrawer();
                        });
                      }),
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'segoeui',
                        ),
                        decoration: InputDecoration.collapsed(
                            hintText: "Search Here ..",
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: "segoeui")),
                      ),
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    width: 280,
                    height: 37,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(75),
      ),
    );
  }

  Widget customDrawer() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Drawer(
          elevation: 0,
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/haldrawerr.png"),
                          fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        child: GestureDetector(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 35,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        padding: EdgeInsets.only(
                            top: (screenUtil.height / 50) - 5,
                            left: screenUtil.width / 50),
                      ),
                      Padding(
                        child: InkWell(
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(ImgURL),
                            radius: 75,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                      Name: UserName,
                                      College: User[0].College.toString(),
                                      ImgUrl:ImgURL,
                                      NID: User[0].NID.toString(),
                                        )));
                          },
                          radius: 75,
                        ),
                        padding: EdgeInsets.only(
                            top: (screenUtil.height / 100) - 10,
                            left: (screenUtil.width / 20) + 7),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(top: screenUtil.height / 100),
                          child: Center(
                            child: Text(
                              "$UserName",
                              style: TextStyle(
                                  fontFamily: 'segoeui',
                                  fontSize: 20,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 4, left: (screenUtil.width / 10), bottom: 10),
                        child: Text(
                          "Student",
                          style: TextStyle(
                              fontFamily: 'segoeui',
                              fontSize: 20,
                              color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                          height: (MediaQuery.of(context).size.height) - 350,
                          width: 200,
                          child: ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: ListView(
                              primary: false,
                              padding: EdgeInsets.only(bottom: 10),
                              children: <Widget>[
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.today,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Schedules",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Lectures",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.group,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Sections",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.receipt,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Result",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.event_available,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Events",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Saved",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "About",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.help_outline,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Help",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    child: Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  title: Text(
                                    "Log out",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future FetchUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String CurrUID = user.uid;
    DatabaseReference Ref =
        FirebaseDatabase.instance.reference().child("Users");
    StorageReference storageRef = FirebaseStorage.instance.ref().child(CurrUID);
    getURL = await storageRef.getDownloadURL() as String;

    Ref.child(CurrUID).once().then((DataSnapshot snapshot) {
      var data = snapshot.value;
      User.clear();
      userData UserData = userData(
          data["FullName"],
          data["NationalID"],
          data["College"],
          data["Grade"],
          data["Sections"],
          data["Notifications"],
          data["IMG"]);
      User.add(UserData);
      setState(() {
        ImgURL = getURL;
        UserName = User[0].Name.toString();
      });
    });
  }
}
