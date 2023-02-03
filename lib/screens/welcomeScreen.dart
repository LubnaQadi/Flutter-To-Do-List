import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/widget/task/display_list.dart';

import '../database/task_provider.dart';
import '../model/tasks.dart';
import '../widget/drawer/drawer.dart';
import '../widget/subtask/details.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          child: DrawerTask(),
        ),
        appBar: AppBar(
          title: Text("Welcome", style: TextStyle(fontSize: 20),),
        ),

        body: Column(
          children: [

            SizedBox(height: 80,),
            Padding(padding: EdgeInsets.only(top: 80, left: 15, right: 15),
            child: Text('Welcome Back Lubna \n                 :)',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black54),),),

            SizedBox(height: 60,),
          //  Image.asset("image/welcome.jpg"),
            Padding(
              padding: EdgeInsets.only(top: 300, left: 15, right: 15),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DisplayList())),
                label: Text(
                  "Add Tasks",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                icon: Icon(Icons.add, color: Colors.black),
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
            )



          ],
        )
    );
  }
}
