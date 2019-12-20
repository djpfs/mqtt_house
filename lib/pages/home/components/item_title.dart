import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

Widget title(BuildContext context, String title, {icon: Icon, hasIcon: bool}) {
  return Padding(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 3,
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.w800,
            ),
          ),
          hasIcon
              ? Icon(
                  FeatherIcons.chevronUp,
                  color: Theme.of(context).primaryColorLight,
                )
              : SizedBox(
                  width: 1,
                )
        ],
      ));
}
