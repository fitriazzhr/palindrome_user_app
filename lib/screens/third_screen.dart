import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.fetchUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          provider.hasMore &&
          !provider.isLoading) {
        provider.fetchUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final users = provider.users;

    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: RefreshIndicator(
        onRefresh: () async {
          await provider.fetchUsers(refresh: true);
        },
        child: users.isEmpty && !provider.isLoading
            ? Center(child: Text('No users found.'))
            : ListView.builder(
                controller: _scrollController,
                itemCount: users.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (ctx, i) {
                  if (i == users.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final user = users[i];
                  return ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    onTap: () {
                      provider.setSelectedUser(user);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
      ),
    );
  }
}
