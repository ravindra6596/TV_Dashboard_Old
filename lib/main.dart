import 'package:flutter/material.dart';
import 'package:tv_dashboard/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(accentColor: Colors.blue),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      drawer: Container(
          width: 200,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.only(bottom: 10),
              children: <Widget>[
                Container(
                  height: 88,
                  child: DrawerHeader(
                    child: Text(""),
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Profile",
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.leaderboard,
                    color: Colors.black,
                  ),
                  title: Text("Leads"),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.group,
                    color: Colors.black,
                  ),
                  title: Text("Users"),
                ),
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          )),
      body: DashBoard(),
    );
  }
}
