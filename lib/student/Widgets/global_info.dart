import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../public/utils/constant.dart';
import '../../public/utils/font_style.dart';

class GlobalInfo extends StatelessWidget {
  const GlobalInfo({
    required String fullname,
    required String name,
    required IconData? icon,
    Key? key,
  })  : _fullname = fullname,
        _name = name,
        _icon = icon,
        super(key: key);

  final String _fullname;
  final String _name;
  final IconData? _icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          Icon(
            _icon,
            color: gray,
            size: 27,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_fullname,
                  style: redHatMediumStyle(fontSize: 11, color: gray)),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 300.w,
                child: Text(
                  _name,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: redHatMediumStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
