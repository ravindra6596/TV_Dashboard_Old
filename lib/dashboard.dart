import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Timer timer;
  int counter = 0;

  var totalLeads;
  Future<List<dynamic>> fetchUsers() async {
    String url = 'http://us.rdigs.com/jsonData.php';
    var result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      throw Exception('Failed');
    }
  }

  String name(dynamic name) {
    return name['name'];
  }

  String leads(dynamic leads) {
    return leads['leads'];
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            padding: EdgeInsets.only(top: 5),
            height: 70,
            color: Colors.cyan[100],
            child: Center(
                child: Column(
              children: [
                Text(
                  "Total Leads",
                  style: new TextStyle(
                    fontSize: 28.0,
                  ),
                ),
                Text(
                  totalLeads.toString(),
                  style: new TextStyle(
                    fontSize: 25.0,
                  ),
                )
              ],
            )),
          ),
        ),
        Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: fetchUsers(),
                builder: (context, snapshot) {
                  totalLeads = snapshot.data
                      .map<int>((m) => int.parse(m["leads"]))
                      .reduce((a, b) => a + b);
                  print(totalLeads.toString());
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              MediaQuery.of(context).size.height / 340,
                        ),
                        padding: EdgeInsets.all(8),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                side: BorderSide(color: Colors.black)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          name(snapshot.data[index]),
                                          style: new TextStyle(
                                            fontSize: 25.0,
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              leads(snapshot.data[index])
                                                  .toString(),
                                              style: new TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ))
                                      ],
                                    )),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }))
      ],
    ));
  }
}
