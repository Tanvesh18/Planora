import '../aftersignin/assigntask.dart';
import '../aftersignin/task.dart';
import 'package:flutter/material.dart';
import '../aftersignin/help.dart';
import '../aftersignin/aboutus.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser;

var myDrawer = Drawer(
  child: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('background/finaldrawerbg.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user?.photoURL ?? ''),
                radius: 30,
              ),
              SizedBox(height: 20),
              Text(
                user?.displayName ?? 'User',
                style: TextStyle(
                    fontFamily: 'Impact', color: Colors.white, fontSize: 12),
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${user?.email}',
                style: TextStyle(
                    fontFamily: 'Impact', color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          return ListTile(
            leading: Icon(
              Icons.calendar_today,
              size: 29,
              color: Colors.white,
            ),
            title: Text(
              'Task',
              style: TextStyle(
                fontFamily: 'Impact',
                fontSize: 20,
                letterSpacing: 1.7,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Task()));
            },
          );
        }),
        Builder(builder: (context) {
          return ListTile(
            leading: Icon(
              Icons.calendar_month,
              size: 29,
              color: Colors.white,
            ),
            title: Text(
              'Assign Task',
              style: TextStyle(
                fontFamily: 'Impact',
                fontSize: 20,
                letterSpacing: 1.7,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Assigntask()));
            },
          );
        }),
        Builder(builder: (context) {
          return ListTile(
            leading: Icon(
              Icons.group,
              size: 29,
              color: Colors.white,
            ),
            title: Text(
              'About Us',
              style: TextStyle(
                fontFamily: 'Impact',
                fontSize: 20,
                letterSpacing: 1.7,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Aboutus()));
            },
          );
        }),
        Builder(builder: (context) {
          return ListTile(
            leading: Icon(
              Icons.search_outlined,
              size: 29,
              color: Colors.white,
            ),
            title: Text(
              'Help',
              style: TextStyle(
                fontFamily: 'Impact',
                fontSize: 20,
                letterSpacing: 1.7,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Help()));
            },
          );
        }),
        Builder(builder: (context) {
          return ListTile(
            leading: Icon(
              Icons.logout,
              size: 29,
              color: Colors.white,
            ),
            title: Text(
              'LOGOUT',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.7,
                color: Colors.white,
                fontFamily: 'Impact',
              ),
            ),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                print('User logged out successfully');
                Navigator.pushReplacementNamed(
                    context, '/signin'); // Redirect to Login Page
              } catch (e) {
                print("Logout failed: $e");
              }
            },
          );
        }),
      ],
    ),
  ),
);

var myAppBar = AppBar(
  elevation: 4,
  backgroundColor: Colors.transparent,
  centerTitle: true,
  title: Text(
    'PLANORA',
    style: TextStyle(
      fontFamily: 'Impact',
    ),
  ),
);
