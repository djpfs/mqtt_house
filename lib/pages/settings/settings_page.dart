import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mqtt/pages/home/components/index.dart' as HomeComponents;

Container pageSettings(BuildContext context) {
  return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              HomeComponents.title(context, "MQTT", hasIcon: false),
              ListTile(
                title: Text(
                  'Servidor',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
                subtitle: Text('tailor.cloudmqtt.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    )),
                leading: Icon(
                  FeatherIcons.server,
                  color: Theme.of(context).primaryColorLight,
                ),
                onTap: null,
              ),
              ListTile(
                title: Text('Usuário',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16)),
                subtitle: Text('dmtkqxon',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    )),
                leading: Icon(FeatherIcons.user,
                    color: Theme.of(context).primaryColorLight),
              ),
              ListTile(
                title: Text('Senha',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16)),
                subtitle: Text('gdyO-C8eiEX5',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    )),
                leading: Icon(FeatherIcons.lock,
                    color: Theme.of(context).primaryColorLight),
              ),
              ListTile(
                title: Text('Porta (No SSL)',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16)),
                subtitle: Text('16879',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    )),
                leading: Icon(FeatherIcons.globe,
                    color: Theme.of(context).primaryColorLight),
              ),
            ],
          )));
}

editServer(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bc) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: TextField(),
        );
      });
}
