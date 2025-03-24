// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
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
  bool isLoading = false; // Typing indicator flag
  String bufferedResponse = ""; // Buffer for streamed text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      body: Stack(
        children: [
          _buildBackground(),
          _buildChatUI(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return mybackground;
  }

  Widget _buildChatUI() {
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
      typingUsers: isLoading ? [geminiUser] : [], // Show typing indicator
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages.insert(0, chatMessage);
      isLoading = true; // Show typing indicator
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }

      bufferedResponse = ""; // Reset buffer

      gemini.streamGenerateContent(question, images: images).listen((event) {
        String partialResponse = event.content?.parts
                ?.map((part) => (part as TextPart).text)
                .join(" ") ??
            "";

        bufferedResponse += " " + partialResponse; // Append new text safely

        setState(() {
          messages.removeWhere((m) => m.user == geminiUser); // Remove old Gemini message
          messages.insert(
            0,
            ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: _cleanResponse(bufferedResponse),
            ),
          );
        });
      }, onError: (error) {
        debugPrint('Error: $error');
        _showError("Something went wrong while generating a response.");
      }, onDone: () {
        setState(() => isLoading = false); // Hide typing indicator
      });
    } catch (e) {
      debugPrint('Error: $e');
      _showError("Unexpected error occurred.");
    }
  }

  /// Cleans up AI response (fixes contractions, removes extra spaces)
  String _cleanResponse(String response) {
    return response
        .replaceAll(" '", "'") // Fixes misplaced apostrophes
        .replaceAll("\n", " ") // Remove unnecessary newlines
        .replaceAll(RegExp(r'\s+'), ' ') // Remove extra spaces
        .trim();
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture?",
          medias: [
            ChatMedia(
              url: file.path,
              fileName: file.name,
              type: MediaType.image,
            )
          ],
        );

        _sendMessage(chatMessage);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      _showError("Failed to pick image.");
    }
  }

  void _showError(String message) {
    setState(() => isLoading = false); // Hide typing indicator
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
