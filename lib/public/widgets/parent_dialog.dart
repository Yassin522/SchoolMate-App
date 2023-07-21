

import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/constant.dart';
import '../utils/font_style.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: use_key_in_widget_constructors
class CustomDialog extends StatelessWidget {



  final Uri _url = Uri.parse('http://mail.google.com/mail?hl=nl');
 void _launchUrl() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}

  dialogContent(BuildContext context) {
    return Container(
      decoration:   BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
           BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children:  <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
               "Note",
               style: sfBoldStyle(fontSize: 16, color: primaryColor),
               
            ),
          ),
          SizedBox(height: 24,),
          
          Text(
             "In case you didn't sign your account into\nthe school, or you need to UPDATE it,\nsend an Email contains your details,\nyour email account and your children\ninformation.",
             style: sfRegularStyle(fontSize: 13, color: black),
             
          ),
          SizedBox(height: 15,),

           InkWell(
            onTap: _launchUrl,
             child: Container(
                 width: MediaQuery.of(context).size.width / 1.8,
                   height: 35,
                 child: Center(
                   child: Text(
                 'Send',
                   style: sfMediumStyle(fontSize: 16,color: white),
                ),
                 ),
               
                  
                   decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(
               12.0,
                     ),
             gradient:gradientColor
                 ),
             ),
           ),

           SizedBox(height: 15,),

         
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}