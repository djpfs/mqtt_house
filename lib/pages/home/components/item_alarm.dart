import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

Widget itemAlarme(BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        color: Theme.of(context).primaryColor,
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Alarme',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(
                      FeatherIcons.shield,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.zero, right: Radius.circular(10)),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                  ),
                ),
              ],
            )),
      ));
}
