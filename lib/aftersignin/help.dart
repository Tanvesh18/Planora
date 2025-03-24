import 'dart:ui';

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
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('background/newbg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Consistent Padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: Task Management
                  sectionTitle('📌 Importance of Task Management'),
                  sectionText(
                      'Task management is essential for organizing, prioritizing, and completing your tasks efficiently. '
                      'With good task management, you can increase productivity, reduce stress, and meet deadlines effectively.'),
                  const SizedBox(height: 16),
                  sectionTitle('🎯 Benefits for Users'),
                  BulletPoint(text: '✔️ Increases productivity and efficiency'),
                  BulletPoint(text: '✔️ Helps you stay organized and focused'),
                  BulletPoint(text: '✔️ Reduces stress by managing deadlines'),
                  BulletPoint(
                      text: '✔️ Improves time management and prioritization'),
                  BulletPoint(
                      text: '✔️ Ensures important tasks are not forgotten'),

                  const SizedBox(height: 24),

                  // Section 2: How to Use the App
                  sectionTitle('📱 How to Use Planora'),
                  BulletPoint(
                      text:
                          '📝 **Adding Tasks**: Tap on the "Add Task" button and enter the task details.'),
                  BulletPoint(
                      text:
                          '📅 **Task Calendar**: View tasks in a calendar format to plan efficiently.'),
                  BulletPoint(
                      text:
                          '✅ **Mark Completed**: Click the checkbox to mark a task as completed.'),
                  BulletPoint(
                      text:
                          '📊 **Task Overview**: Get a summarized view of all your tasks.'),
                  BulletPoint(
                      text:
                          '🔄 **Sync Across Devices**: Your tasks are saved using Firebase, so they are accessible anywhere.'),

                  const SizedBox(height: 24),

                  // Section 3: Using Gemini AI Chatbot
                  sectionTitle('🤖 Introduction to Gemini Chatbot'),
                  sectionText(
                      'Gemini Chatbot is an advanced AI assistant designed to help you manage tasks, answer questions, '
                      'and provide smart recommendations. It uses deep learning to process natural language and generate useful responses.'),
                  BulletPoint(
                      text:
                          '🔹 **Smart Task Suggestions**: Get recommendations based on your task history.'),
                  BulletPoint(
                      text:
                          '🔹 **Quick Reminders**: Ask the chatbot to remind you about important tasks.'),
                  BulletPoint(
                      text:
                          '🔹 **Instant Help**: Get AI-powered answers to your questions instantly.'),

                  const SizedBox(height: 24),

                  // Encouragement Text
                  Center(
                    child: Text(
                      '🚀 Start managing your tasks efficiently today!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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

  // A reusable widget for section titles
  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.blue[300], // Light blue for better contrast
      ),
    );
  }

  // A reusable widget for section descriptions
  Widget sectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

// Custom bullet point widget
class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.greenAccent, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
