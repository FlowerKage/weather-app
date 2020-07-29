import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart' as utils;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  void getData() async {
    Map data = await getWeatherData(utils.apiID, utils.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Klimatic",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: getData,
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/background.jpg",
              width: 470.0,
              height: 1200,
              fit: BoxFit.fill,
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.all(20.0),
              child: Text(
                "Johannesburg",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset("assets/images/light_rain.png"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 100.0, 140.0, 0.0),
              alignment: Alignment.center,
              child: showData("Johannesburg"),
            ),
          ],
        ),
      ),
    );

//    return Scaffold(
//        appBar: AppBar(
//      title: Text(
//        "Klimatic",
//        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
//      ),
//      actions: <Widget>[
//        IconButton(icon: Icon(Icons.menu), onPressed: () {}),
//      ],
//          backgroundColor: Colors.black,
//    ),
//      body: ListView(
//        children: <Widget>[
//          Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                alignment: Alignment.topCenter,
//                margin: const EdgeInsets.only(top: 400.0),
//                child: Text("20C",style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.w600),),
//              ),
//            ],
//          ),
//
//        ],
//      ),
//      backgroundColor: Colors.black,
   // );
  }
}

Widget showData(String city) {
  return FutureBuilder(
      future: getWeatherData(utils.apiID, city),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return Container(
            child: Column(
              children: <Widget>[
                Text(
                  "${content['main']['temp'].toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      });
}

Future<Map> getWeatherData(String apiID, String city) async {
  String apiUrl =
      "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=e${utils.apiID}&units=metric";
  http.Response response = await http.get(apiUrl);
  return jsonDecode(response.body);
}
