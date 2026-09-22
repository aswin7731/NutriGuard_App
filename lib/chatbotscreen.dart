import 'package:flutter/material.dart';
import 'package:nutriguardapp/familydashboard.dart';
import 'package:nutriguardapp/homepage.dart';
import 'package:nutriguardapp/profile_dashboard.dart';
import 'package:nutriguardapp/scanningpage.dart'; 


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  
  int _selectedIndex = 3; // Chat tab is index 3
  
  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Is this product safe for pregnancy?",
      "isUser": true,
    },
    {
      "text": "This product is not ideal during pregnancy. It contains refined flour, added sugar and palm oil. Try choosing high-fiber, low-sugar options with natural ingredients.",
      "isUser": false,
    }
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        "text": _messageController.text.trim(),
        "isUser": true,
      });
      _messageController.clear();
      
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.add({
              "text": "I can help you analyze more ingredients once we connect the AI backend API!",
              "isUser": false,
            });
          });
        }
      });
    });
  }

  // NEW: Bottom Sheet for Attachment Options
  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, color: Color(0xFF0284C7)),
                  ),
                  title: const Text('Take Photo', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Trigger camera
                    print("Take Photo Selected");
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                    child: const Icon(Icons.image, color: Color(0xFF0284C7)),
                  ),
                  title: const Text('Upload Image', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Trigger gallery picker
                    print("Upload Image Selected");
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                    child: const Icon(Icons.insert_drive_file, color: Color(0xFF0284C7)),
                  ),
                  title: const Text('Upload File', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Trigger document picker
                    print("Upload File Selected");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primarySkyBlue = Color(0xFF0284C7); 
    const appBackgroundSky = Color(0xFFF0F9FF); 
    const aiBubbleColor = Color(0xFFE0F2FE); 

    return Scaffold(
      backgroundColor: appBackgroundSky,
      
      // Top Navigation Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            // Navigate back to Home
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeDashboard()));
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.auto_awesome, color: primarySkyBlue, size: 20),
            SizedBox(width: 8),
            Text(
              'AI Chat Assistant',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),

      // Bottom Navigation Footer
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, 
        backgroundColor: Colors.white,
        selectedItemColor: primarySkyBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            // CONNECTED: Navigates to HomeDashboard
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeDashboard()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanScreen()));
          } 
           else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FamilyMembersScreen()));
          }
            else if (index == 4) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }

        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.family_restroom_outlined), activeIcon: Icon(Icons.family_restroom), label: 'Family'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),

      // Main Chat Interface
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["isUser"];
                
                return _buildChatBubble(
                  text: message["text"], 
                  isUser: isUser, 
                  primarySkyBlue: primarySkyBlue, 
                  aiBubbleColor: aiBubbleColor
                );
              },
            ),
          ),
          
          // Bottom Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, -4), blurRadius: 10)
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // FIXED: Only one attachment button that opens the modal
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: _showAttachmentOptions, // Triggers the popup
                  ),
                  
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: primarySkyBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 20),
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

  Widget _buildChatBubble({required String text, required bool isUser, required Color primarySkyBlue, required Color aiBubbleColor}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75, 
        ),
        decoration: BoxDecoration(
          color: isUser ? primarySkyBlue : aiBubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}