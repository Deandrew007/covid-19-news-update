import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String newsUrl = "https://cryptic-ravine-96718.herokuapp.com/";
  List data;

  @override
  void initState() {
    super.initState();
    this.getNewsData();
  }

  Future<String> getNewsData() async {
    var response = await http
        .get(Uri.encodeFull(newsUrl), headers: {"Accept": "application/json"});
    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['news'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Covid-19 Updates"),
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                          new Container(
                            child: new Text(data[index]['title']),
                            padding: const EdgeInsets.all(20.0),
                          ),
                          new Container(
                            child: Image.network(data[index]['img']),
                          )
                        ])),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
