import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'second_screen.dart';

class FirstScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  bool isPalindrome(String input) {
    final cleaned = input.replaceAll(' ', '').toLowerCase();
    return cleaned == cleaned.split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ebd5), Color(0xFFACB6E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue, size: 40),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Palindrome',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    final result = isPalindrome(textController.text);
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: Text(result ? 'isPalindrome' : 'not palindrome'),
                      ),
                    );
                  },
                  child: const Text('CHECK'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .setInputName(nameController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SecondScreen()),
                    );
                  },
                  child: const Text('NEXT'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
