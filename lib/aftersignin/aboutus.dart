import 'package:authenticationprac/constants/constants.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  final List<Map<String, String>> teamMembers = [
    {'name': 'Aniket Tamnar', 'info': 'Frontend UI designing\n'},
    {'name': 'Mahesh Tamnar', 'info': 'Frontend & Backend\n Developer'},
    {'name': 'Tanvesh Deshmukh', 'info': 'Full Stack Development\n'},
    {'name': 'Tanay Lathi', 'info': 'Backend developer\n'},
    {'name': 'Tanisha Kawale', 'info': 'Designing \n'},
    {'name': 'Aarushi Tandon', 'info': 'Backend developer\n'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        drawer: myDrawer,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('background/newbg.jpeg'), // Background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Introduction About App',
                    style: TextStyle(
                      
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome to our study management system app!\n'
                    '\n'
                    '1) Course Organization: Centralizes all course materials, assignments, and schedules.\n'
                    '2) Progress Tracking: Monitoring performance of students through grades, attendance, and feedback.\n'
                    '3) Communication Tools: Enhances interaction between students and teachers with messaging and notification systems\n'
                    '4) Resource Management: Provides access to a library of educational resources and materials.\n'
                    '5) Intelligent Tutoring: AI-driven tutoring systems offer personalized learning experiences based on individual student needs and learning styles.\n'
                    '6) Automated Administrative Tasks: Automates routine administrative tasks like grading, attendance tracking, and schedule management, freeing up educators to focus more on teaching\n'
                    '7) Enhanced Communication: Uses AI to facilitate communication between students and teachers through smart chatbots and automated notifications.\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Team Members:',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                  const SizedBox(height: 32),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: teamMembers.map((member) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                member['name']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                member['info']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'App Tools Information',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Our app includes a variety of tools designed to enhance your experience:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('background/flutterpic.jpg'),
                                ),
                              ),
                            ),
                            const Text(
                              'Flutter IDE',
                              style: TextStyle(
                                fontSize: 16,
                                
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:AssetImage('background/firebasepic.jpg'),
                              ),
                            ),
                          ),
                          const Text(
                            'Firebase',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                              height: 150,
                              width: 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('background/vscodepic.jpg'),
                                ),
                              )),
                          const Text(
                            'VS Code',
                            style: TextStyle(
                              
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Version Control: Git is a distributed version control system that helps developers track and manage changes in their codebase\n'
                    'Collaboration: It allows multiple developers to work on the same project simultaneously without interfering with each others work.\n'
                    'Branching and Merging: Git makes it easy to create branches for new features, bug fixes, or experiments, and then merge them back into the main codebase when they ready.\n'
                    'History and Audit: Every change is recorded with a timestamp and author information, making it possible to review and revert to previous versions if needed\n'
                    'Integration: Git integrates with various platforms like GitHub, GitLab, and Bitbucket for cloud-based repositories and additional tools for code reviews, CI/CD, and project management\n',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
