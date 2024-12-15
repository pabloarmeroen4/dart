import 'package:flutter/material.dart';
import 'package:youtube_web/screen/upload_screen.dart';
import 'package:youtube_web/screen/subscriber_screen.dart';

void main() {
  runApp(const VideoHubApp());
}

class VideoHubApp extends StatelessWidget {
  const VideoHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const VideoHubHomePage(),
    );
  }
}

class VideoHubHomePage extends StatefulWidget {
  const VideoHubHomePage({super.key});

  @override
  _VideoHubHomePageState createState() => _VideoHubHomePageState();
}

class _VideoHubHomePageState extends State<VideoHubHomePage> {
  Widget _currentView = const Center(
    child: Text(
      'Welcome to Video Hub',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Hub'),
        backgroundColor: Colors.blue,
      ),
      drawer: VideoHubDrawer(
        onOptionSelected: (Widget view) {
          setState(() {
            _currentView = view;
          });
          Navigator.pop(context);
        },
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _currentView,
      ),
    );
  }
}

class VideoHubDrawer extends StatelessWidget {
  final Function(Widget) onOptionSelected;

  const VideoHubDrawer({super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: const Text('User Name'),
            accountEmail: const Text('user@example.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.blue),
            title: const Text('Dashboard'),
            onTap: () {
              onOptionSelected(const Center(
                child: Text(
                  'Welcome to Video Hub',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_call, color: Colors.blue),
            title: const Text('Upload Videos'),
            onTap: () {
              onOptionSelected(const UploadScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.people, color: Colors.blue),
            title: const Text('Subscribers'),
            onTap: () {
              onOptionSelected(const SubscriberScreen());
            },
          ),
        ],
      ),
    );
  }
}
