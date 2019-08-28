import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'Timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'noGlow.dart';
import 'dart:async';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
Color mainColor=Color.fromRGBO(74, 176, 255,1);

double defaultScreenWidth = 400.0;
double defaultScreenHeight = 810.0;
ScreenUtil screenUtil=ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:mainColor,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  Color mainColor = Color.fromRGBO(74, 176, 255,1);

  GlobalKey contkey=GlobalKey();
  GlobalKey<ScaffoldState> snakeState=GlobalKey<ScaffoldState>();
  GlobalKey<FormState> SigninKey =GlobalKey<FormState>();
  var opc=0.0;
  Animation animation;
  AnimationController animationController;
  bool destroy;
  String email;
  String password;

  FirebaseAuth Myauth=FirebaseAuth.instance;
  @override
  void initState() {
    destroy=false;
    animationController=AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    animation=Tween(begin: 0.0,end:-0.3).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn
      )
    );
    Future.delayed(Duration(seconds: 2),(){
      animationController.forward();
    });
    Future.delayed(Duration(seconds: 5),(){
      setState(() {
        setState(() {
          opc=1.0;
          destroy=true;
        });
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      key: snakeState,
      body: Stack(
        children: <Widget>[
          Signin(),
          splashScreen()
        ],
      ),
    );
  }
  StatefulWidget splashScreen() {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return AnimatedBuilder(
        key: contkey,
        animation: animationController,
        builder: (BuildContext context, Widget itm) {
          return Transform(
            transform: Matrix4.translationValues(
                0.0, animation.value * height, 0.0),
            child: Opacity(
              opacity: 1.0,
                  child: Center(
                    child: Image.asset(
                      "images/brochure.png", width: 230, height: 230,),
                )

            ),
          );
        }
    );
  }
  Widget Signin(){
    return AnimatedOpacity(
        opacity: opc,
        duration: Duration(seconds: 2),
        child: Container(
          child: Form(
            child: Padding(
              padding: EdgeInsets.only(top: 200),
              child: ScrollConfiguration(
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 5,left: 33,top: 70),
                        child: Text("Email",style: TextStyle(
                            fontSize: 23,
                            fontFamily:'segoeui'
                        ),)
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20,left: 30,right: 30),
                        child: TextFormField(
                          onSaved: (value)=> email=value,
                          validator: (val){
                            if(val.isEmpty){
                              return "Please enter you E-mail";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "examble@gmail.com",
                              hasFloatingPlaceholder: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(80)
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 5,left: 33),
                        child: Text("Password",style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'segoeui'
                        ),)
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          obscureText: true,
                          onSaved: (value) => password =value,
                          validator: (val){
                            if(val.isEmpty){
                              return "Please enter you password";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Password",
                              hasFloatingPlaceholder: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(80)
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child:  Center(
                        child: SizedBox(
                          width: 140,
                          height: 40,
                          child: RaisedButton(
                            onPressed: (){
                              SigninMethod();
                            },
                            color: Colors.blue[300],
                            child: Text("Login",style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'segoeui'
                            ),),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text("Don`t have an account?",style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'segoeui'
                        ),),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        child: Center(
                          child: Text("Sign up",style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'segoeui',
                              color: mainColor
                          ),),
                        ),
                        padding: EdgeInsets.only(top: 5),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                    ),
                    Center(
                      child:Padding(
                        padding: EdgeInsets.only(top: 10,left: 20),
                        child: Image.asset("images/undraw_Graduation_ktn0.png",width: 180,height: 182,),
                      )
                      ,
                    )
                  ],
                ),
                behavior: MyBehavior(),
              ),
            ),
            key: SigninKey,
          ),
          color: Colors.white,
        ),
    );
  }
  Future<void> SigninMethod() async{
    if(SigninKey.currentState.validate())
      {
        SigninKey.currentState.save();
        try{
          final FirebaseUser user = await Myauth.signInWithEmailAndPassword(email: email, password: password);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Timeline()));
        }catch(e){
          ShowSnak(e);
        }
      } else{
      ShowSnak("Save Your Details first");
    }
  }
  void ShowSnak(String msg){
    var snak=SnackBar(content: Text(msg),duration: Duration(seconds: 3),backgroundColor: mainColor,);
    snakeState.currentState.showSnackBar(snak);
  }
}
