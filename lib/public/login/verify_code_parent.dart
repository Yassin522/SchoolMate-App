import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/util.dart';
import '../widgets/custom_verify_textfield.dart';

class OtpParent extends StatefulWidget {
  @override
  _OtpParentState createState() => _OtpParentState();
}

final TextEditingController _charA = TextEditingController();
final TextEditingController _charB = TextEditingController();
final TextEditingController _charC = TextEditingController();
final TextEditingController _charD = TextEditingController();
GetStorage storage = GetStorage();

late String A, B, C, D;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

String? str = UserInformation.fullname;
var arr = str!.split(' ');

final newparent = {
  "uid": UserInformation.User_uId,
  "email": UserInformation.email,
  "first_name": arr[0],
  "last_name": arr[1],
  "phone": UserInformation.phone,
  "urlAvatar": UserInformation.urlAvatr,
};

class _OtpParentState extends State<OtpParent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Get.off('/login'),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/illustration-3.png',
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                const Text(
                  "Enter your Parent code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28.h,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textFieldOTP(
                            first: true,
                            last: false,
                            controller: _charA,
                            onChange: (String value) {
                              setState(() {
                                A = value;
                              });
                            },
                          ),
                          textFieldOTP(
                            first: false,
                            last: false,
                            controller: _charB,
                            onChange: (String value) {
                              setState(() {
                                B = value;
                              });
                            },
                          ),
                          textFieldOTP(
                            first: false,
                            last: false,
                            controller: _charC,
                            onChange: (String value) {
                              setState(() {
                                C = value;
                              });
                            },
                          ),
                          textFieldOTP(
                            first: false,
                            last: true,
                            controller: _charD,
                            onChange: (String value) {
                              setState(() {
                                D = value;
                                print(D);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (UserInformation.parentverifycode ==
                                A + B + C + D) {
                              await _firestore
                                  .collection('parents')
                                  .doc(UserInformation.User_uId)
                                  .set(newparent);
                              print("broooooooo");
                              await storage.write(
                                  'uid', UserInformation.User_uId);
                              UserInformation.uParent = true;
                              Get.offAllNamed('/sthome');
                            } else {
                              showSnackBar("Wrong Code", context);
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Verify',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
