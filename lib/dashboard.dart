import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Timer timer;
  int counter = 0;

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
        // backgroundColor: Color.fromRGBO(198, 159, 169, 1),
        body: Column(
      children: [
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            height: 100,
            color: Colors.cyan[100],
            child: Center(
                child: Column(
              children: [
                Text(
                  "Total Leads",
                  style: new TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  "100",
                  style: new TextStyle(
                    fontSize: 30.0,
                  ),
                )
              ],
            )),
          ),
        ),
        Expanded(
            child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
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
                            padding: EdgeInsets.fromLTRB(10, 40, 0, 10),
                            child: Column(
                              children: [
                                Container(
                                    child: Text(
                                  "Prathamesh",
                                  style: new TextStyle(
                                    fontSize: 25.0,
                                  ),
                                )),
                                Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "25",
                                      style: new TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ))
                              ],
                            )),
                      ],
                    ),
                  );
                }))
      ],
    ));
  }
}
