// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:chat_bot/Controller/Backend/chatbot_controller.dart';
import 'package:chat_bot/Controller/Database/database_controller.dart';
import 'package:chat_bot/Controller/input_controllers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InterfacePage extends StatefulWidget {
  const InterfacePage({super.key});

  @override
  State<InterfacePage> createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  // INSTANCE FOR INPUT CONTROLLERS
  final InputControllers inputControllers = InputControllers();
  // INSTANCE FOR DATABASE CONTROLLER
  final DatabaseController databaseController = DatabaseController();
  //  SCROLL CONTROLLER
  final ScrollController scrollController = ScrollController();
  //  METHOD TO SCROLL TO THE BOTTOM
  void scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatbotController = Provider.of<ChatbotController>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF000000),

      drawer: Expanded(child: Drawer(backgroundColor: Colors.grey.shade900)),
      //  APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Quorion".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontSize: height * 0.025,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.cinzel().fontFamily,
          ),
        ),
      ),
      //  BODY
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatbotController>(
              builder: (context, chatbotController, child) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: chatbotController.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatbotController.messages[index];
                    final isUser = message["sender"] == "user";
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.green : Colors.grey[800],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          message["text"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputControllers.messageController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white, // Set the cursor color to white
                    
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      labelText: "Hey there! How can I help you?",
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.grey[900]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.grey.shade800),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.black!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      if (inputControllers.messageController.text.isNotEmpty) {
                        chatbotController.isLoading =
                            true; // Show loading indicator
                        chatbotController.notifyListeners();

                        await chatbotController.fetchResponse(
                          inputControllers.messageController.text,
                        );

                        inputControllers.messageController
                            .clear(); // Clear input field after sending
                        chatbotController
                            .scrollToBottom(); // Scroll to bottom after sending
                        scrollToBottom();
                      }
                    },
                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.03),
        ],
      ),
    );
  }
}
