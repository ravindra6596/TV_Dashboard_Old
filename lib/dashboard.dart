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
  Future<List<dynamic>> fetchUsers() async {
    String url = 'http://us.rdigs.com/jsonData.php';
    //  print(url);

    var result = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    //print(result.statusCode);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      // If the server not return a 200 OK ,
      // then throw the exception.
      throw Exception('Failed');
    }
  }

  String name(dynamic name) {
    return name['name'];
  }

  String leads(dynamic leads) {
    return leads['leads'];
  }

  /*  Future<UserData> userdata;
  @override
  void initState() {
    super.initState();
    userdata = fetchUsers();
  }
 */
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

  var totalLeads;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromRGBO(198, 159, 169, 1),
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
                  Text('Data');
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          childAspectRatio:
                              MediaQuery.of(context).size.height / 350,
                        ),
                        padding: EdgeInsets.all(8),
                        itemBuilder: (BuildContext context, int index) {
                          //  print(leads(snapshot.data[index]));

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

  void submitData(Map x) async {
    var tot = 0;

    x.forEach((key, leads) {
      tot += (leads[1]);
      print('Total Leads');
      print(tot);
    });
  }
}
