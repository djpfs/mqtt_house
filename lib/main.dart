import 'dart:async';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt/pages/settings/settings_page.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'chip.dart';
import 'pages/home/home_page.dart';

void main() => runApp(MyApp());

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JP\'s HOUSE',
      theme: ThemeData(
          backgroundColor: hexToColor('#151517'),
          primarySwatch: Colors.blue,
          primaryColor: hexToColor('#151517'),
          primaryColorDark: hexToColor('#1a1d1a'),
          primaryColorLight: hexToColor('#ec2158')),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'JP\'s HOUSE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String broker = 'tailor.cloudmqtt.com';
  int port = 16879;
  String username = 'dmtkqxon';
  String passwd = 'gdyO-C8eiEX5';
  String clientIdentifier = 'android';

  mqtt.MqttClient client;
  mqtt.MqttConnectionState connectionState;

  StreamSubscription subscription;
  bool lamp = false;
  int _selectedIndex = 0;

  bool alarmStatusCard = true;
  bool lampStatusCard = true;

  PageController pageController = new PageController(initialPage: 0);

  void _subscribeToTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] Subscribing to ${topic.trim()}');
      client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
    }
  }

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Icon(FeatherIcons.bell),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(FeatherIcons.grid, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(FeatherIcons.list,
                color: Theme.of(context).primaryColorLight),
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColorLight),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        toolbarOpacity: 1,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          pageHome(context),
          Container(
            color: Colors.cyan,
          ),
          Container(
            color: Colors.deepPurple,
          ),
          Container(
            color: Colors.redAccent,
          ),
          pageSettings(context),
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0,
        hasInk: true,
        hasNotch: false,
        backgroundColor: Theme.of(context).primaryColorDark,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            this._selectedIndex = index;
            this.pageController.jumpToPage(index);
          });
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 20,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColorLight,
            icon: Icon(
              FeatherIcons.home,
              color: Colors.white70,
            ),
            activeIcon: Icon(
              FeatherIcons.home,
              color: Theme.of(context).primaryColorLight,
            ),
            title: Text("Casa",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          ),
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColorLight,
            icon: Icon(
              FeatherIcons.sun,
              color: Colors.white70,
            ),
            activeIcon: Icon(
              FeatherIcons.sun,
              color: Theme.of(context).primaryColorLight,
            ),
            title: Text("Iluminação",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          ),
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColorLight,
            icon: Icon(
              FeatherIcons.shield,
              color: Colors.white70,
            ),
            activeIcon: Icon(
              FeatherIcons.shield,
              color: Theme.of(context).primaryColorLight,
            ),
            title: Text("Alarme",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          ),
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColorLight,
            icon: Icon(
              FeatherIcons.tv,
              color: Colors.white70,
            ),
            activeIcon: Icon(
              FeatherIcons.tv,
              color: Theme.of(context).primaryColorLight,
            ),
            title: Text("Eletônicos",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          ),
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColorLight,
            icon: Icon(
              FeatherIcons.sliders,
              color: Colors.white70,
            ),
            activeIcon: Icon(
              FeatherIcons.sliders,
              color: Theme.of(context).primaryColorLight,
            ),
            title: Text("Config.",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          ),
        ],
      ),
    );
  }

  Widget _categoryScroll() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 35,
          width: MediaQuery.of(context).size.width * 0.2,
          child: Row(
            children: <Widget>[],
          ),
        ),
        Container(
          height: 35,
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              chipItem('ILUMINAÇÃO', Theme.of(context).primaryColorLight),
              SizedBox(
                width: 10,
              ),
              chipItem('ELETRÔNICOS', Theme.of(context).primaryColorDark),
            ],
          ),
        )
      ],
    );
  }

  void _connect() async {
    client = mqtt.MqttClient(broker, '');
    client.port = port;
    client.logging(on: true);
    client.keepAlivePeriod = 30;
    client.onDisconnected = _onDisconnected;

    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        .withWillQos(mqtt.MqttQos.atMostOnce);
    print('[MQTT client] MQTT client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect(username, passwd);
    } catch (e) {
      print(e);
      _disconnect();
    }

    /// Check if we are connected
    if (client.connectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] connected');
      setState(() {
        connectionState = client.connectionState;
      });
    } else {
      print('[MQTT client] ERROR: MQTT client connection failed - '
          'disconnecting, state is ${client.connectionState}');
      _disconnect();
    }

    subscription = client.updates.listen(_onMessage);

    _subscribeToTopic("lamp");
  }

  void _disconnect() {
    client.disconnect();
    _onDisconnected();
  }

  void _sendMessage() {
    const String pubTopic = 'lamp';
    final mqtt.MqttClientPayloadBuilder builder =
        mqtt.MqttClientPayloadBuilder();
    builder.addString(this.lamp ? 'OFF' : 'ON');

    client.publishMessage(pubTopic, mqtt.MqttQos.exactlyOnce, builder.payload);

    setState(() {
      this.lamp = !this.lamp;
    });
  }

  void _onDisconnected() {
    print('[MQTT client] Desconectando...');
    setState(() {
      //topics.clear();
      connectionState = client.connectionState;
      client = null;
      subscription.cancel();
      subscription = null;
    });
    print('[MQTT client] Cliente desconectado');
  }

  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    if (message == 'ON') {
      setState(() {
        this.lamp = true;
      });
    } else if (message == 'OFF') {
      setState(() {
        this.lamp = false;
      });
    }
  }
}
