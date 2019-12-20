import 'package:flutter/material.dart';
import 'components/index.dart' as HomeComponents;

SingleChildScrollView pageHome(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HomeComponents.title(context, "LÂMPADAS", hasIcon: true),
          Column(
            children: <Widget>[
              HomeComponents.itemHouse('Sala', context),
              HomeComponents.itemHouse('Quarto', context),
              HomeComponents.itemHouse('Cozinha', context),
              HomeComponents.itemHouse('Banheiro', context),
            ],
          ),
          HomeComponents.title(context, "ALARME", hasIcon: true),
          HomeComponents.itemAlarme(context),
          HomeComponents.title(context, "ELETRÔNICOS", hasIcon: true),
        ],
      ),
    ),
  );
}
