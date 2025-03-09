import 'package:authenticationprac/gemini/gemini.dart';
import 'package:authenticationprac/user_info_page.dart';
import '../assigntaskonly/assigntask.dart';
import '../tasksonly/task.dart';
import 'package:flutter/material.dart';
import '../aftersignin/help.dart';
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
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new page when the avatar is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInfoPage(user: user!), // Replace with your target page
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user?.photoURL ?? ''),
                      radius: 30,
                    ),
                  );
                },
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
        Builder(builder: (BuildContext context) {
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
              Icons.chat,
              size: 29,
              color: Colors.white,
            ),
            title: Text(
              'Gemini Chatbot',
              style: TextStyle(
                fontFamily: 'Impact',
                fontSize: 20,
                letterSpacing: 1.7,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Chatbot()));
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
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  backgroundColor: Color.fromARGB(255, 0, 28, 43),
  centerTitle: true,
  title: Text(
    'PLANORA',
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'Impact',
      letterSpacing: 1.5,
    ),
  ),
);
