import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final name = provider.inputName;
    final selectedUser = provider.selectedUser;
    final selectedName = selectedUser != null
        ? "${selectedUser.firstName} ${selectedUser.lastName}"
        : "-";

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFc9ffbf), Color(0xFFffafbd)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(name ?? '-', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      Text(
                        'Selected User:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(selectedName, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ThirdScreen()),
                    );
                  },
                  child: const Text('CHOOSE A USER'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
