import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildContactCard(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'Send us an email',
              value: 'support@newcatholichymnal.com',
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              icon: Icons.phone,
              title: 'Phone',
              subtitle: 'Call us',
              value: '024 000 0000 / 020 000 0000',
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              icon: Icons.location_on,
              title: 'Address',
              subtitle: 'Visit us',
              value: 'Queen Of Peace Catholic Church - Madina, Accra - Ghana',
            ),
            const SizedBox(height: 30),
            const Text(
              'About This App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'The NewCatholic Hymnal is a digital collection of traditional updated Catholic hymns '
              'designed to help you sing, worship and pray through Catholic Mass.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(value, style: const TextStyle(color: Colors.teal)),
        onTap: () {
          // Handle contact action
        },
      ),
    );
  }
}
