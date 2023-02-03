import 'dart:core';
import 'dart:ui';
import '/screens/welcomeScreen.dart';
import '/screens/wishScreen.dart';

import '/screens/todayScreen.dart';
import 'package:flutter/material.dart';
import '/screens/birthdaysScreen.dart';
import '/screens/personalScreen.dart';
import '/screens/shoppingScreen.dart';
import '/screens/workScreen.dart';
import '/widget/task/display_list.dart';

class DrawerTask extends StatefulWidget {
  const DrawerTask({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerTask> createState() => _DrawerTaskState();
}

class _DrawerTaskState extends State<DrawerTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("image/Farida.jpg"),
              ),

              accountName: Text('Lubna Qadi'),
              accountEmail: Text('alqadi.lubna@gmail.com'),
              decoration: BoxDecoration(color: Colors.blue),

            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today_outlined,
                color: Colors.orange,
              ),
              title: Text('Today'),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TodayScreen())),
            ),
            ListTile(
              leading: Icon(
                Icons.inbox,
                color: Colors.orange,
              ),
              title: Text('Inbox'),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => DisplayList())),
            ),
            ListTile(
              leading: Icon(
                Icons.waving_hand,
                color: Colors.orange,
              ),
              title: Text('Welcome'),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WelcomeScreen())),
            ),
            ListTile(
              leading: Icon(
                Icons.work_outlined,
                color: Colors.brown,
              ),
              title: Text('Work'),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WorkScreen())),
            ),
            ListTile(
              leading: Icon(
                Icons.house_sharp,
              ),
              title: Text('Personal'),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PersonalScreen())),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.orange,
              ),
              title: Text('Shopping'),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ShoppingScreen())),
            ),
            ListTile(
              leading: Icon(
                Icons.card_giftcard_outlined,
                color: Colors.orange,
              ),
              title: Text('Wish List'),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WishScreen())),
            ),
            ListTile(
              leading: Icon(
                Icons.cake_outlined,
                color: Colors.orange,
              ),
              title: Text('Birthday'),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BirthdaysScreen())),
            ),
            /*Padding(
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () {},
                label: Text(
                  "Add List",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                icon: Icon(Icons.add, color: Colors.black),
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
