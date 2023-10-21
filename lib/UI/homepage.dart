import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};



  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/2'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userData = data['data'];
      });
    } else {
      // Handle error
    }
  }


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: userData.isEmpty
            ? CircularProgressIndicator()
            : ProfileCard(userData),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  ProfileCard(this.userData);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userData['avatar']),
            ),
            title: Text('${userData['first_name']} ${userData['last_name']}'),
            subtitle: Text('Email: ${userData['email']}'),
          ),
        ],
      ),
    );
  }
}
