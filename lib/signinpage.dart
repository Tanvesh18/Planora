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
  bool isLoading = false; // Loading state
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void showSnackbar(String message, {Color backgroundColor = Colors.orangeAccent}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 18.0)),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Future<void> userLogin(String email, String password) async {
    if (!_formkey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Task()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showSnackbar("Incorrect password. Please try again.");
      } else {
        showSnackbar("An unexpected error occurred. Please try again.");
      }
    } catch (_) {
      showSnackbar("Something went wrong. Please try again later.", backgroundColor: Colors.redAccent);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showSnackbar("Google sign-in canceled.", backgroundColor: Colors.grey);
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (_) {
      showSnackbar("Google sign-in failed. Try again!", backgroundColor: Colors.redAccent);
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
            decoration: const BoxDecoration(
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
                  const Icon(Icons.task_alt_rounded, color: Colors.white, size: 100),
                  const SizedBox(height: 16),
                  const Text(
                    'PLANORA',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Impact',
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'MASTER YOUR TASKS, ELEVATE YOUR TIME!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
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
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                  .hasMatch(value)) {
                                return 'Enter a valid email address';
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
                            style: const TextStyle(color: Colors.white),
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
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        userLogin(emailController.text.trim(), passwordController.text.trim());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
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
                    child: Row(
                      children: [
                        const Expanded(child: Divider(color: Colors.white, thickness: 2)),
                        const Text(
                          'OR SIGN IN WITH',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const Expanded(child: Divider(color: Colors.white, thickness: 2)),
                      ],
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
                              MaterialPageRoute(builder: (context) => Task()),
                            );
                          }
                        },
                        child: Container(
                          width: 60,
                          height: 65,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Image(
                            image: AssetImage('background/googlelogo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 60,
                        height: 70,
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Image(
                          image: AssetImage('background/applelogo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
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
