import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authenticationprac/constants/constants.dart';

class UserInfoPage extends StatelessWidget {
  final User user;

  const UserInfoPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('background/newbg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Dark Overlay for better text visibility
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          // User Info Section
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    backgroundImage: user.photoURL != null && user.photoURL!.isNotEmpty
                        ? NetworkImage(user.photoURL!)
                        : const AssetImage('background/default_avatar.png') as ImageProvider,
                    radius: 50,
                  ),
                  const SizedBox(height: 20),

                  // Display Name
                  Text(
                    'Hello, ${user.displayName ?? "User"}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Email
                  Text(
                    'Email: ${user.email ?? "Not Available"}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
