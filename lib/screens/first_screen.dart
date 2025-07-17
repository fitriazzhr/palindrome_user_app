import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'second_screen.dart';
import '../providers/user_provider.dart';

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
      appBar: AppBar(title: Text('Palindrome Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final result = isPalindrome(textController.text);
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: Text(result ? 'isPalindrome' : 'not palindrome'),
                  ),
                );
              },
              child: Text('Check'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false)
                    .setInputName(nameController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SecondScreen()),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
