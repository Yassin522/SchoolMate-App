import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/constant.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String? name;

  const ProfileHeaderWidget({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 80,
        padding: EdgeInsets.all(16).copyWith(left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white),
                Expanded(
                  child: Text(
                    name!,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildIcon(Icons.call),
                    SizedBox(width: 12),
                    buildIcon(Icons.videocam),
                  ],
                ),
                SizedBox(width: 4),
              ],
            )
          ],
        ),
      );

  Widget buildIcon(IconData icon) => Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: secondaryColor,
        ),
        child: Icon(icon, size: 25, color: Colors.white),
      );
}
