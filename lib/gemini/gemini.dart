// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'package:authenticationprac/constants/constants.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(firstName: 'User', id: "0");
  ChatUser geminiUser = ChatUser(firstName: 'Gemini', id: "1");

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
         _buildUi(),
        ],
      ),
    );
  }

  Widget _buildUi() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(
            onPressed: _sendMediaMessage,
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;

      // Check for media and convert to bytes if available
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }

      gemini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? lastMessage = messages.isNotEmpty ? messages.first : null;

        String response = event.content?.parts
                ?.map((part) => (part as TextPart).text)
                .join(" ") ??
            "";

        // Update the chat with Gemini's response
        if (lastMessage != null && lastMessage.user == geminiUser) {
          if (messages.isNotEmpty) {
            messages.removeAt(0); // Remove the last message if it's from Gemini
          }
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage, ...messages];
          });
        } else {
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      debugPrint('Error: $e');
      // Optionally, show an alert to the user about the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
      );
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();

    // Request gallery access and handle permission errors
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        // Ensure file name is captured
        String fileName = file.name;

        // Send media message
        ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture?",
          medias: [
            ChatMedia(
              url: file.path,
              fileName: fileName, // Use the file's name
              type: MediaType.image,
            )
          ],
        );

        _sendMessage(chatMessage);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }
}
