import 'package:authenticationprac/constants/constants.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('background/newbg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView( // Wrap the content inside SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Add padding to the content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  Text(
                    'Importance of Task Management',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800], // Dark blue text for heading
                    ),
                  ),
                  SizedBox(height: 16), // Add some spacing between text

                  // Explanation of Task Management
                  Text(
                    'Task management is the process of planning, organizing, and prioritizing tasks to efficiently complete projects or goals. Effective task management ensures that no tasks are missed and helps you stay on track. It leads to better productivity and reduced stress.',
                    style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 16), // Add some spacing

                  // Benefits of Task Management
                  Text(
                    'Benefits for the User:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  BulletPoint(text: 'Increases productivity and efficiency'),
                  BulletPoint(text: 'Helps you stay organized and focused'),
                  BulletPoint(text: 'Reduces stress by managing deadlines'),
                  BulletPoint(text: 'Improves time management and prioritization'),
                  BulletPoint(text: 'Ensures important tasks are not forgotten'),
                  SizedBox(height: 24),
                  Text(
                    'Start organizing your tasks today and experience the benefits of effective task management!',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 24),

                  // Introduction to Gemini AI
                  Text(
                    'Introduction to Gemini Chatbot:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Gemini Chatbot is an advanced artificial intelligence model developed by Google DeepMind. It combines multiple AI techniques to understand and generate human-like text, recognize patterns, and provide solutions to complex problems. Gemini AI leverages powerful machine learning algorithms, including deep learning, to process vast amounts of data, making it highly effective for tasks like natural language understanding, image recognition, and more.',
                    style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 255, 255, 255)),
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

// A custom widget for bullet points
class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.blue, size: 18),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
