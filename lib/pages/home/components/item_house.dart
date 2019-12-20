import 'package:flutter/material.dart';

Widget itemHouse(String name, BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        color: Theme.of(context).primaryColorDark,
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(
                      Icons.lightbulb_outline,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 80,
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
