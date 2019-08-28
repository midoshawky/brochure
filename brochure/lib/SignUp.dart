import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main.dart';
import 'dart:async';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  Color mainColor = Color.fromRGBO(74, 176, 255,1) ;

  bool secured=true;
  bool Boolnoti=false;
  bool Boolterm=false;

  IconData see ;

  var opcSee=1.0;
  var txtHieght;
  String currItm="Faculty of Engineering";
  String gradeCurrItm="First";
  String sectionCurrItm="1";
  List<String> colleges =["Faculty of Engineering","Faculty of sience","Faculty of art","Faculty of commerce"];
  List<String> grade =["First","Second","Third","Fourth"];
  List<String> section =["1","2","3","4"];

  String Fname,Email,Pass,Nid,Col,grades,sec,noti,url;
  File Fimage;

  GlobalKey<FormState> key=GlobalKey<FormState>();
  @override
  void initState() {
    txtHieght=50.0;
    see=Icons.remove_red_eye  ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Form(
        key: key,
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: mainColor,
                        size: 35,
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    padding: EdgeInsets.only(left: 15, right: 55),
                  ),
                  Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.blue[300],
                              child:(Fimage!=null)? ClipRRect(
                                child: Image.file(Fimage,fit: BoxFit.cover,width: 200,height: 200,),
                                borderRadius: BorderRadius.circular(200),
                              ):Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 140,
                              ),
                            ),
                            Positioned(
                              child:GestureDetector(
                                child:  CircleAvatar(
                                  backgroundColor: Colors.black87,
                                  radius: 17,
                                  child:  Icon(Icons.add,color: Colors.white,),
                                ),
                                onTap: (){
                                  getImg();
                                },
                              ),
                              left: 125,
                              top: 140,
                            )
                          ],
                        )
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 10,left: 30,right: 30),
                    child: SizedBox(
                      child: TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Please Enter Your Full Name";
                          }
                        },
                        onSaved: (String val){
                          Fname = val;
                        },
                        decoration: InputDecoration(
                            labelText: "Full name",
                            labelStyle: TextStyle(
                                fontSize:20
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))
                        ),
                      ),
                      width: 350,
                      height: txtHieght,
                    )
                ),
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 30),
                    child: SizedBox(
                      child: TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Please Enter an E-mail";
                          }
                        },
                        onSaved: (val) => Email=val,
                        decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                                fontSize:20
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))
                        ),
                      ),
                      width: 350,
                      height: txtHieght,
                    )
                ),
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 30),
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          child:  TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                setState(() {
                                  txtHieght=70.0;
                                  opcSee=0.0;
                                });
                                return "Please enter a password";
                              }else{
                                txtHieght=30.0;
                                opcSee=1.0;
                              }
                            },
                            onSaved: (val) => Pass=val,
                            obscureText: secured,
                            decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    fontSize:20
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25))
                            ),
                          ),
                          width: 350,
                          height: txtHieght,
                        ),
                        Positioned(
                          child: Opacity(
                            child: IconButton(
                                icon: Icon(see,color: Colors.blue[300],),
                                onPressed: (){
                                  setState(() {
                                    if(see==Icons.visibility_off){
                                      see=Icons.remove_red_eye;
                                      secured=true;
                                    }else
                                    {
                                      see=Icons.visibility_off;
                                      secured=false;
                                    }
                                  });
                                }),
                            opacity: opcSee,
                          ),
                          left: 280,
                        ),
                      ],
                    )
                ),
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 30),
                    child: SizedBox(
                      child: TextFormField(
                        maxLength: 14,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Please Enter your National ID";
                          }
                        },
                        onSaved: (val) => Nid = val,
                        decoration: InputDecoration(
                            labelText: "National ID",
                            labelStyle: TextStyle(
                                fontSize:20
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))
                        ),
                      ),
                      width: 350,
                      height: txtHieght+18,
                    )
                ),
              ),
              Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 30),
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: "College",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                              ),
                              disabledBorder: OutlineInputBorder(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: currItm
                            ),
                            items: colleges.map((String itm){
                              return DropdownMenuItem <String>(
                                value: itm,
                                child: Text(itm),
                              );
                            }).toList(),
                            onChanged: (String newItm){
                              setState(() {
                                this.currItm=newItm;
                                this.Col=newItm;
                              });
                            },
                            value: currItm,
                          ),
                          width: 350,
                          height: 60,
                        )
                      ],
                    )
                ),
              ),
              Center(
                child: Wrap(
                  spacing: 25,
                  children: <Widget>[
                    SizedBox(
                      child:DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: "Grades",
                            labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                            disabledBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: currItm
                        ),
                        items: grade.map((String itm){
                          return DropdownMenuItem<String>(
                            value: itm,
                            child:Text(itm),
                          );
                        }).toList(),
                        onChanged: (String newItm){
                          setState(() {
                            this.gradeCurrItm=newItm;
                            this.grades=newItm;
                          });
                        },
                        value: gradeCurrItm,
                      ),
                      width: 150,
                    ),
                    SizedBox(
                      child:DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: "Sections",
                            labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                            disabledBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: currItm
                        ),
                        items: section.map((String itm){
                          return DropdownMenuItem<String>(
                            value: itm,
                            child:Text(itm),
                          );
                        }).toList(),
                        onChanged: (String newItm){
                          setState(() {
                            this.sectionCurrItm=newItm;
                            this.sec = newItm;
                          });
                        },
                        value: sectionCurrItm,
                      ),
                      width: 150,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Send notifications"),
                  Checkbox(
                      value: Boolnoti,
                      onChanged: (bool val){
                        setState(() {
                          this.Boolnoti=val;
                          noti=val.toString();
                        });
                      }
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Agree to the terms"),
                  Checkbox(
                      value: Boolterm,
                      onChanged: (bool val){
                        setState(() {
                          this.Boolterm=val;
                        });
                      }
                  )
                ],
              ),
              Center(
                child: SizedBox(
                  width: 140,
                  height: 40,
                  child: RaisedButton(
                    onPressed: (){
                      SignUpMethod();
                    },
                    color: Colors.blue[300],
                    child: Text("Confirm",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
Future<void> SignUpMethod() async {

    if(key.currentState.validate()){
      key.currentState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: Pass);
        DatabaseReference myRef =  FirebaseDatabase.instance.reference();
        var UID=user.uid;
        var Data={
          "FullName" :Fname,
          "NationalID" :Nid,
          "College" : Col,
          "Grade" : grades,
          "Sections" : sec,
          "Notifications":noti,
          "IMG": url
        };
        UploadImg(UID);
        myRef.child("Users").child(UID).set(Data).then((val){
          key.currentState.reset();
        });
        Completed();
      }catch(e){
        print(e);
      }
    }
}

Future getImg() async {
    var Img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState((){
      Fimage=Img;
    });
}
Future UploadImg(String RefID) async {
    StorageReference storageRef = FirebaseStorage.instance.ref().child(RefID);
    StorageUploadTask task= storageRef.putFile(Fimage);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
     url = await storageRef.getDownloadURL() as String;
    print(url);
}

Future<void> Completed() async {
    await showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(40)
              ),
              height: 430,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 0),
                      child:Container(
                        width:(MediaQuery.of(context).size.width)-50,
                        child:Padding(
                          child: Image(image: AssetImage("images/animated-check.gif"),width:300 ,height: 220,),
                          padding: EdgeInsets.only(top: 15),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                        ),
                        margin: EdgeInsets.all(0),
                      )
                  ),
                  Padding(
                    child: Text("$Fname",style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: "segoui"
                    ),),
                    padding: EdgeInsets.only(top: 20,bottom: 10),
                  ),
                  Text("You Successfully Registered",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "segoui"
                  ),),
                  Padding(
                    padding: EdgeInsets.only(top: 5,right:9 ,bottom: 5,left: 9),
                    child: Divider(),
                  ),
                  FlatButton(
                    child: Text("Dismiss",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=> MyApp()));
                    },
                  )
                ],
              ),
            ),
          );
        },
        barrierDismissible: false
    );
  }
}
