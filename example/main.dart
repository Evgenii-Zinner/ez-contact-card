import 'package:flutter/material.dart';
import 'package:ez_contact_card/ez_contact_card.dart';
import 'package:ez_circle_avatar/ez_circle_avatar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Contact Card Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EZ Contact Card Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionHeader(title: '1. Basic Usage'),
          EzContactCard(
            name: 'Jane Doe',
            avatar: const EzCircleAvatar(name: 'Jane Doe'),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '2. With Subtitle'),
          EzContactCard(
            name: 'John Smith',
            subtitle: 'Software Engineer',
            avatar: const EzCircleAvatar(name: 'John Smith'),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '3. With Action (Tail)'),
          EzContactCard(
            name: 'Alice Johnson',
            subtitle: 'Product Manager',
            avatar: const EzCircleAvatar(name: 'Alice Johnson'),
            tail: IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {
                debugPrint('Calling Alice...');
              },
            ),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '4. Fully Styled'),
          EzContactCard(
            name: 'Design System Card',
            subtitle: 'Custom decoration & text styles',
            avatar: const EzCircleAvatar(name: 'Design System'),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.grey.shade200),
            ),
            contentPadding: const EdgeInsets.all(20),
            nameStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            subtitleStyle: TextStyle(
              color: Colors.indigo.shade300,
              fontStyle: FontStyle.italic,
            ),
            gap: 24,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '5. Long Text Handling'),
          EzContactCard(
            name: 'Christopher Alexander Williamson',
            subtitle:
                'Senior Vice President of Global Engineering & Technology',
            avatar: const EzCircleAvatar(name: 'CW'),
            tail: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
