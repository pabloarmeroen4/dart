import 'package:flutter/material.dart';

class SubscriberScreen extends StatefulWidget {
  const SubscriberScreen({super.key});

  @override
  State<SubscriberScreen> createState() => _SubscriberScreenState();
}

class _SubscriberScreenState extends State<SubscriberScreen> {
  final List<Map<String, String>> _subscribers = [
    {'name': 'Alice', 'email': 'alice@example.com'},
    {'name': 'Bob', 'email': 'bob@example.com'},
    {'name': 'Charlie', 'email': 'charlie@example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscribers'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _subscribers.length,
        itemBuilder: (context, index) {
          final subscriber = _subscribers[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(subscriber['name']!),
              subtitle: Text(subscriber['email']!),
            ),
          );
        },
      ),
    );
  }
}
