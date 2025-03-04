import 'package:authenticationprac/tasksonly/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  String email = "", password = "";
  bool isHovered = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    if (!_formkey.currentState!.validate()) {
      return; // Return if the form is not valid
    }

    try {
      // Attempt login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Navigate to Homepage on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Task(tasks: [],)),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Please try again.";
      } else {
        errorMessage = "An unexpected error occurred. Please try again.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.orangeAccent,
        ),
      );
    } catch (e) {
      // Catch any other unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Something went wrong. Please try again later.",
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 203, 203),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('background/coolbg2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.task_alt_rounded,
                  color: Colors.white,
                  size: 100,
                ),
                const SizedBox(height: 16),
                const Text(
                  'PLANORA',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Impact',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'MASTER YOUR TASKS,ELEVATE YOUR TIME!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16  ,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(0, 0, 0, 0.5),
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(0, 0, 0, 0.5),
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text.trim();
                        password = passwordController.text.trim();
                      });
                      userLogin();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontFamily: 'Impact',
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: const Color.fromARGB(
                                255, 255, 255, 255), // Line color
                            thickness: 2,
                          ),
                        ),
                        Text(
                          'OR SIGN IN WITH',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: const Color.fromARGB(
                                255, 255, 255, 255), // Line color
                            thickness:
                                2, // Line thickness // Empty space to the right of the line
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        User? user = await signInWithGoogle();
                        if (user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Task(tasks: [],),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 60,
                        height: 65,
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('background/googlelogo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20, width: 20),
                    Container(
                      width: 60,
                      height: 70,
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('background/applelogo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
