import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_management_system/public/auth/auth_methods.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/public/login/dividerforparent.dart';
import 'package:school_management_system/public/login/dividerwithtext.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import 'package:school_management_system/public/widgets/circuled_button.dart';
import 'package:school_management_system/public/widgets/custom_button.dart';
import 'package:school_management_system/public/widgets/custom_formfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:school_management_system/public/widgets/parent_dialog.dart';
import 'package:school_management_system/student/view/Home/messaging.dart';
import '../utils/util.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/rounded_button.dart';
import '../widgets/send_email_container.dart';
import 'login_label.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  bool student = false;
  bool teacher = false;
  bool admin = false;
  bool parent = false;
  var stcolor = gradientColor2,
      adcolor = gradientColor2,
      tecolor = gradientColor2,
      parcolor = gradientColor2;
  var sticotextcolor = gray,
      adicotextcolor = gray,
      teicotextcolor = gray,
      paricotextcolor = gray;

  GoogleSignInAccount? _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GetStorage storage = GetStorage();
  String url = "";
  String name = "";
  String email = "";
  String txt1 = "", txt2 = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  initialMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      Navigator.of(context).pushNamed("Studenthome");
    }
  }

  @override
  void initState() {
    super.initState();
    teacher = true;
    tecolor = gradientColor;
    teicotextcolor = Colors.white;
    initialMessage();
    fbm.getToken().then((token) {
      print("=================================================");
      print(token);
      UserInformation.Token = token;
      print("=================================================");
    });
  }

  @override
  Widget build(BuildContext context) {
    Pics pics = Pics();
    Size size = MediaQuery.of(context).size;

    final RoundedLoadingButtonController _buttonController =
        RoundedLoadingButtonController();
    bool _isLoading = false;

    @override
    void dispose() {
      super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
    }

    void Login() async {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().loginStudent(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (res == "success") {
        if (student) {
          bool okst = false;

          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection('students')
              .where("uid", isEqualTo: UserInformation.User_uId)
              .get();

          if (snap.docs.isNotEmpty) {
            okst = true;
          } else {
            okst = false;
          }
          print("fffffffffffffff");
          print(okst);

          print("Studenttttttttt");
          print(okst);

          String docID;
          String docID2;
          if (okst) {
            await FirebaseFirestore.instance
                .collection('students')
                .where('email', isEqualTo: _emailController.text)
                .get()
                .then((value) async {
              for (var i = 0; i < value.docs.length; i++) {
                UserInformation.fees = value.docs[i]['fees'];
                UserInformation.classid = value.docs[i]['class_id'];
                UserInformation.first_name = value.docs[i]['first_name'];
                UserInformation.last_name = value.docs[i]['last_name'];
                UserInformation.phone = value.docs[i]['phone'];
                UserInformation.parentphone = value.docs[i]['parent_phone'];
                UserInformation.classroom = value.docs[i]['class_name'];
                UserInformation.clasname = value.docs[i]['class_name'];
                UserInformation.urlAvatr = value.docs[i]['urlAvatar'];
                UserInformation.grade_average = value.docs[i]['grade_average'];
                UserInformation.grade = value.docs[i]['grade'];
                print(UserInformation.fees);
                print(UserInformation.first_name);
                print(UserInformation.last_name);
                print(UserInformation.phone);
                print(UserInformation.parentphone);
                print(UserInformation.classroom);
                print(UserInformation.urlAvatr);
                print(UserInformation.grade_average);
              }
            });

            print("tmmmmmmmm");
            await FirebaseFirestore.instance
                .collection('students')
                .doc(UserInformation.User_uId)
                .update({
              'token': UserInformation.Token,
            });
          }
          if (okst)
            Get.offAllNamed('/sthome');
          else {
            showSnackBar("You are not a student", context);
          }
        }
        if (teacher) {
          bool okte = false;

          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection('teacher')
              .where("uid", isEqualTo: UserInformation.User_uId)
              .get();

          if (snap.docs.isNotEmpty) {
            okte = true;
          } else {
            okte = false;
          }
          print("teacherrrrrrrrrrrrr");
          print(okte);

          if (okte) {
            String docID;
            await FirebaseFirestore.instance
                .collection('teacher')
                .where('uid', isEqualTo: UserInformation.User_uId)
                .get()
                .then((value) async {
              for (var i = 0; i < value.docs.length; i++) {
                UserInformation.first_name = value.docs[i]['first_name'];
                UserInformation.last_name = value.docs[i]['last_name'];
                UserInformation.phone = value.docs[i]['phone'];
                UserInformation.Subjects = value.docs[i]['subjects'];
                UserInformation.email = value.docs[i]['email'];
                UserInformation.urlAvatr = value.docs[i]['urlAvatar'];

                print(UserInformation.first_name);
                print(UserInformation.last_name);
                print(UserInformation.phone);
                print(UserInformation.Subjects);
                print(UserInformation.email);
                print(UserInformation.urlAvatr);
              }
            });

            print("tmmmmmmmm");
            await FirebaseFirestore.instance
                .collection('teacher')
                .doc(UserInformation.User_uId)
                .update({
              'token': UserInformation.Token,
            });
          }

          if (okte)
            Get.offAllNamed('/teahome');
          else
            showSnackBar("You are not a teacher", context);
        }
      } else {
        showSnackBar(res, context);
      }

      setState(() {
        _isLoading = false;
      });
    }

    void google() async {
      GoogleSignIn googleSign = GoogleSignIn();
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
      if (googleSignInAccount == null) {
        CustomFullScreenDialog.cancelDialog();
      } else {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        try {
          final UserCredential userCredential =
              await firebaseAuth.signInWithCredential(oAuthCredential);
        } catch (e) {
          print(e);
        }
        UserInformation.User_uId = firebaseAuth.currentUser!.uid;
        UserInformation.email = firebaseAuth.currentUser!.email!;
        UserInformation.urlAvatr = firebaseAuth.currentUser!.photoURL!;
        UserInformation.fullname =
            firebaseAuth.currentUser!.displayName.toString();
        UserInformation.phone =
            firebaseAuth.currentUser!.phoneNumber.toString();
        String str = firebaseAuth.currentUser!.displayName.toString();
        var arr = str.split(' ');
        print(firebaseAuth.currentUser!.displayName);
        print(firebaseAuth.currentUser!.photoURL);
        print(firebaseAuth.currentUser!.phoneNumber);
        print(firebaseAuth.currentUser!.uid);
        CustomFullScreenDialog.cancelDialog();
        print("eeeeeeeeeeee");
        print(UserInformation.User_uId);
        print(UserInformation.email);

        if (teacher) Get.toNamed('/verify');
        if (parent) Get.toNamed('/verifyparent');
      }

      _buttonController.reset();
    }

    void setstring() {
      _passwordController.text = txt2;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/login-background-squares.png",
                ),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 72.h,
                    ),
                    const Loginlabel(),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Text(
                      "I am",
                      style: sfBoldStyle(fontSize: 24, color: gray),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          circuledButton(
                              pic: pics.teacherGreyPic,
                              text: 'teacher',
                              background: tecolor,
                              icontextcolor: teicotextcolor,
                              press: () {
                                setState(() {
                                  adcolor = gradientColor2;
                                  tecolor = gradientColor;
                                  parcolor = gradientColor2;
                                  stcolor = gradientColor2;
                                  adicotextcolor = gray;
                                  teicotextcolor = Colors.white;
                                  sticotextcolor = gray;
                                  paricotextcolor = gray;
                                  admin = false;
                                  teacher = true;
                                  student = false;
                                  parent = false;
                                });
                              }),
                          circuledButton(
                              pic: pics.studentGreyPic,
                              text: 'student',
                              background: stcolor,
                              icontextcolor: sticotextcolor,
                              press: () {
                                setState(() {
                                  adcolor = gradientColor2;
                                  tecolor = gradientColor2;
                                  parcolor = gradientColor2;
                                  stcolor = gradientColor;
                                  adicotextcolor = gray;
                                  teicotextcolor = gray;
                                  sticotextcolor = Colors.white;
                                  paricotextcolor = gray;
                                  admin = false;
                                  teacher = false;
                                  student = true;
                                  parent = false;
                                });
                              }),
                          circuledButton(
                              pic: pics.parentGreyPic,
                              text: 'parent',
                              background: parcolor,
                              icontextcolor: paricotextcolor,
                              press: () {
                                setState(() {
                                  adcolor = gradientColor2;
                                  tecolor = gradientColor2;
                                  parcolor = gradientColor;
                                  stcolor = gradientColor2;
                                  adicotextcolor = gray;
                                  teicotextcolor = gray;
                                  sticotextcolor = gray;
                                  paricotextcolor = Colors.white;
                                  admin = false;
                                  teacher = false;
                                  student = false;
                                  parent = true;
                                });
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    parent == false
                        ? Form(
                            key: formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Column(children: [
                                customFormField(
                                  controller: _emailController,
                                  label: 'Email',
                                  prefix: Icons.email,
                                  onChange: (String val) {
                                    print(_emailController.text);
                                    // _emailController.text=val;
                                  },
                                  type: TextInputType.emailAddress,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'email must not be empty';
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                customFormField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  prefix: Icons.lock,
                                  onChange: (String val) {
                                    txt2 = _passwordController.text;
                                    //  _passwordController.text=val;
                                  },
                                  suffix: isPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  isPassword: isPassword,
                                  suffixPressed: () {
                                    setState(() {
                                      isPassword = !isPassword;
                                      print(txt2);
                                      setstring;
                                    });
                                  },
                                  type: TextInputType.visiblePassword,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'password is too short';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ]),
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 32.h,
                              ),
                              Text(
                                "Choose the same account given to School! ",
                                style:
                                    sfRegularStyle(fontSize: 12, color: blue),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Roundedbutton(
                                buttonController: _buttonController,
                                press: google,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              const DividerParent(
                                text: "Update your account",
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SendEmail(
                                press: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialog();
                                      });
                                },
                              ),
                            ],
                          ),
                    if (parent == false)
                      SizedBox(
                        height: 32.h,
                      ),
                    if (parent == false)
                      CustomButton(
                        press: Login,
                      ),
                    if (parent == false)
                      SizedBox(
                        height: 32.h,
                      ),
                    if (teacher == true)
                      Column(
                        children: <Widget>[
                          DividerText(
                            text: "or",
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          Roundedbutton(
                            buttonController: _buttonController,
                            press: google,
                          ),
                        ],
                      )
                    else
                      const SizedBox(
                        height: 1.0,
                      ),
                    SizedBox(
                      height: 32.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
