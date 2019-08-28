import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'noGlow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Timeline.dart';
import 'dart:ui';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class Profile extends StatefulWidget {
  const Profile({Key key,this.Name, this.NID, this.College, this.Grades, this.Section,
  this.Notification, this.ImgUrl}):super(key:key);
  @override
  _ProfileState createState() => _ProfileState();
  final String Name,NID,College,Grades,Section,Notification,ImgUrl;
}

class _ProfileState extends State<Profile> {
  Color mainColor = Color.fromRGBO(74, 176, 255, 1);
  double defaultScreenWidth = 400.0;
  double defaultScreenHeight = 810.0;
  var H=0.0,R=0;

  String T="See More";
  ScreenUtil screenUtil=ScreenUtil.instance;

  String Age,Gender,Gov;
  PanelController pannlControl=PanelController();
  MainAxisAlignment BarPos=MainAxisAlignment.start;
  @override
  void initState() {
    getNIDinfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    screenUtil = ScreenUtil(
      width:defaultScreenWidth,
      height: defaultScreenWidth,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color:mainColor,size: 35,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  padding: EdgeInsets.only(left: screenUtil.width/60,top: screenUtil.height/15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: screenUtil.width/200),
                      child: IconButton(
                        icon: Icon(Icons.group,color:mainColor,size: 30,),
                        onPressed: (){
                          setState(() {
                            pannlControl.open();
                          });
                        },
                      ),
                    ),
                    Padding(
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(widget.ImgUrl),
                        radius: 90,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: screenUtil.width/10),
                    ),
                    Padding(
                      child: IconButton(
                        icon: Icon(Icons.chat_bubble,color:mainColor,size: 30,),
                        onPressed: (){
                        },
                      ),
                      padding: EdgeInsets.only(right: screenUtil.width/200),
                    )
                  ],
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        child: Text("${widget.Name}",style: TextStyle(
                            fontSize: 20,
                            fontFamily: "segoeui"
                        ),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.only(top: screenUtil.height/90),
                      ),
                      Padding(
                        child: Text("Student",style: TextStyle(
                            fontSize: 18,
                            fontFamily: "segoeui"
                        ),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.only(top: screenUtil.height/90),
                      ),
                      Padding(
                        child: Text("$Gov, Egypt",style: TextStyle(
                            fontSize: 18,
                            fontFamily: "segoeui"
                        ),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.only(top: screenUtil.height/90),
                      ),
                      Padding(
                        child: Text("${widget.College}, Alexadria Universty",style: TextStyle(
                            fontSize: 18,
                            fontFamily: "segoeui"
                        ),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.only(top: screenUtil.height/90),
                      ),
                      GestureDetector(
                        child: SeeMore(),
                        onTap: (){
                          setState(() {
                            if(H==0){
                              H=100.0;
                              T="See Less";
                              R=2;
                            }else
                            {
                              H=0.0;
                              T="See More";
                              R=0;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SlidingUpPanel(
            maxHeight: 600,
            backdropEnabled: true,
            controller: pannlControl,
            panel: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20)
                            ,topLeft: Radius.circular(20))
                    ),
                    height: 120,
                    child:Card(
                      elevation: 5,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft:Radius.circular(20),
                              topRight: Radius.circular(20)
                          )
                      ),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            child: Center(
                              child: Icon(
                                Icons.group,
                                color: mainColor,
                                size:30,
                              ),
                            ),
                            padding: EdgeInsets.only(top: 9),
                          ),
                          Center(
                            child: Text("Connections",style: TextStyle(
                                fontSize: 20,
                                fontFamily: "segoeui",
                                color: mainColor
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Text("Followers",style: TextStyle(
                                      color: mainColor,
                                      fontSize: 25
                                  ),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      BarPos=MainAxisAlignment.start;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                ),
                                GestureDetector(
                                  child: Text("Following",style: TextStyle(
                                      color: mainColor,
                                      fontSize: 25
                                  ),),
                                  onTap: (){
                                   setState(() {
                                     BarPos=MainAxisAlignment.end;
                                   });
                                  },
                                )
                              ],

                            ),
                          ),
                          Padding(
                            child: Row(
                              mainAxisAlignment: BarPos,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  height: 5,
                                  color: mainColor,
                                )
                              ],
                            ),
                            padding: EdgeInsets.only(top: 4),
                          )
                        ],
                      )
                    )
                ),
                Container(
                  height: screenUtil.height+80,
                  child: ListView(
                    padding: EdgeInsets.only(top: 1),
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/stud.jpg"),
                        ),
                        title: Text("Muhammed Tarek"),
                        subtitle: Text("Student"),
                        trailing: IconButton(
                            icon: Icon(Icons.person_add,)
                            , onPressed: (){

                        }
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            minHeight: 1,
            borderRadius: BorderRadius.only(
              topRight:Radius.circular(20) ,
              topLeft: Radius.circular(20),
            ),
          )
        ],
      ),
    );
  }
  Widget SeeMore(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: H,
          child: ScrollConfiguration(
              child: ListView(
                shrinkWrap: true,
            children: <Widget>[
              Padding(
                child: Text("Age: $Age",style: TextStyle(
                    fontSize: 18,
                    fontFamily: "segoeui"
                ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(top: screenUtil.height/90),
              ),
              Padding(
                child: Text("$Gender",style: TextStyle(
                    fontSize: 18,
                    fontFamily: "segoeui"
                ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(top: screenUtil.height/90),
              ),
              Padding(
                child: Text("Spec : SSP",style: TextStyle(
                    fontSize: 18,
                    fontFamily: "segoeui"
                ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(top: screenUtil.height/90),
              ),
            ],
          ),
            behavior: MyBehavior(),
          ),
        ),
        Padding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("$T",style:TextStyle(
                  color: mainColor,
                  fontSize: 18,
                  fontFamily: "segoeui"
              ),
              ),
              RotatedBox(
                child: Icon(Icons.keyboard_arrow_down,color: mainColor,),
                quarterTurns: R,
              ),
            ],
          ),
          padding:
          EdgeInsets.only(top: H),
        )
      ],
    );
  }
  void getNIDinfo() {
    String NID=widget.NID;
    String BirthYear=NID.substring(1,3);
    String GovCode=NID.substring(7,9);
    String StrGender=NID.substring(9,13);
    var myInt = int.parse(BirthYear);
    var Code = int.parse(GovCode);
    var gender = int.parse(StrGender);
    assert(myInt is int);
    var years=(2019-(myInt+1900));
    setState(() {
      Age=years.toString();
      Gov=gov(Code);
      if(gender%2==0){
        setState(() {
          Gender="Female";
        });
      }else{
        setState(() {
          Gender="Male";
        });
      }
    });
    print("\n You Have $years years old");
    print("you are from ${gov(Code)}");
  }
  String gov(int code){
    String gov;
    switch (code){
      case 1 : {
        gov="Cairo";
        break ;
      }
      case 2 : {
        gov="Alexandria";
        break ;
      }
      case 3 : {
        gov="Port Saied";
        break ;
      }
      case 4 : {
        gov="Suiz";
        break ;
      }
      case 11 : {
        gov="Domyat";
        break ;
      }
      case 12 : {
        gov="Dakahlia";
        break ;
      }
      case 13 : {
        gov="Asharkya";
        break ;
      }
      case 14 : {
        gov="El Qaliubia";
        break ;
      }
      case 15 : {
        gov="Kafr El Shikh";
        break ;
      }
      case 16 : {
        gov="El Gharbia";
        break ;
      }
      case 17 : {
        gov="Menofia";
        break ;
      }
      case 18 : {
        gov="El Buhera";
        break ;
      }
      case 19 : {
        gov="Ismayilia";
        break ;
      }
      case 21 : {
        gov="El Jiza";
        break ;
      }
      case 22 : {
        gov="Bani Swif";
        break ;
      }
      case 23 : {
        gov="Fayoum";
        break ;
      }
      case 24 : {
        gov="Minia";
        break ;
      }
      case 25 : {
        gov="Assiut";
        break ;
      }
      case 26 : {
        gov="Sohag";
        break ;
      }
      case 27 : {
        gov="Qina";
        break ;
      }
      case 28 : {
        gov="Aswan";
        break ;
      }
      case 29 : {
        gov="Luxor";
        break ;
      }
      case 31 : {
        gov="Red Sea";
        break ;
      }
      case 32 : {
        gov="ElWadi ElGded";
        break ;
      }
      case 33 : {
        gov="Marsa Matrouh";
        break ;
      }
      case 34 : {
        gov="Shmal Sina";
        break ;
      }
      case 35 : {
        gov="Ganob Sina";
        break ;
      }
      case 88 : {
        gov="El Buhera";
        break ;
      }
    };
    return gov;
  }

}
