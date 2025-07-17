import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  int _page = 1;
  final int _perPage = 6;
  bool _hasMore = true;
  User? _selectedUser;
  String _inputName = "";

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  User? get selectedUser => _selectedUser;
  String get inputName => _inputName;

  void setInputName(String name) {
    _inputName = name;
    notifyListeners();
  }

  void setSelectedUser(User user) {
    _selectedUser = user;
    notifyListeners();
  }

  Future<void> fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;
    if (refresh) {
      _page = 1;
      _users.clear();
      _hasMore = true;
    }
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://reqres.in/api/users?page=$_page&per_page=$_perPage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<User> fetchedUsers =
          (data['data'] as List).map((json) => User.fromJson(json)).toList();

      if (fetchedUsers.length < _perPage) {
        _hasMore = false;
      } else {
        _page++;
      }

      _users.addAll(fetchedUsers);
    }

    _isLoading = false;
    notifyListeners();
  }
}
