import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  // サーバーからデータを取得
  Future<void> fetchUserData() async {
    const String url = 'http://localhost:8000/users/t0YAKj9FQGRJEUQmJRnFbqYO0A83';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          userData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
          ? const Center(child: Text('Failed to load user data'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userData!['image_url'] != null)
              Center(
                child: Image.network(
                  userData!['image_url'],
                  height: 100,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 100);
                  },
                ),
              ),
            const SizedBox(height: 16),
            Text('Name: ${userData!['name']}',
                style: const TextStyle(fontSize: 18)),
            Text('Email: ${userData!['email']}',
                style: const TextStyle(fontSize: 18)),
            Text('Grade: ${userData!['grade']}',
                style: const TextStyle(fontSize: 18)),
            Text('Group: ${userData!['group']}',
                style: const TextStyle(fontSize: 18)),
            Text('Status: ${userData!['status']}',
                style: const TextStyle(fontSize: 18)),
            Text('Location: ${userData!['now_location']}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
