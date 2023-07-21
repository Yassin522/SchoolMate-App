import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import '../utils/constant.dart';

class Roundedbutton extends StatelessWidget {
  const Roundedbutton({
    Key? key,
    required RoundedLoadingButtonController buttonController,
    required  Function press,

  }) : _buttonController = buttonController,_press=press, super(key: key);

  final RoundedLoadingButtonController _buttonController;
  final Function _press;

  @override
  Widget build(BuildContext context) {
    return Container(  
        height: 56,
        width: 330,
        child: RoundedLoadingButton(
         
         color:Colors.white,
         valueColor:  primaryColor,
          onPressed: ()=> _press.call(),
          child: Wrap(
            
            children: [
              Image(image: AssetImage('assets/icons/google.png')),
                 
              SizedBox(
                width: 24.w,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Log In with Google',
                  style:sfRegularStyle(fontSize: 24.sp,color: darkGray) ,
                ),
              )
            ],
          ),
         
          width: MediaQuery.of(context).size.width * 0.80,
       
          elevation: 2,
          borderRadius: 10,
          controller: _buttonController,
        ),
      );
  }
}