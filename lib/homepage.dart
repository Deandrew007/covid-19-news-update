import 'package:url_launcher/url_launcher.dart';
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
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                          new Container(
                            child: FadeInImage.assetNetwork(
                                placeholder: 'assets/loading.gif',
                                image: data[index]['img']),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: new Container(
                                  child: new Text(
                                    data[index]['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                ),
                              ),
                              Expanded(
                                child: new Container(
                                    child: new IconButton(
                                        icon: Icon(Icons.launch),
                                        onPressed: () async {
                                          final newsLink = data[index]['link'];

                                          if (await canLaunch(newsLink)) {
                                            await launch(newsLink,
                                                forceWebView: true);
                                          } else {
                                            throw 'Could not launch $newsLink';
                                          }
                                        })),
                              ),
                            ],
                          ),
                        ])),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
