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
            const SizedBox(height: 5),
            const Text(
              'About The New Catholic Hymnal 2021',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'The New Catholic Hymnal is a digital compilation of updated traditional Catholic hymns, created to inspire and guide you in singing, worship, and prayer throughout the Catholic Mass.',
              style: TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 10),

            // About Us Section
            const Text(
              'About Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 5),

            // Company Card
            _buildContactCard(
              icon: Icons.business,
              title: 'Company',
              subtitle: 'OLGABYTE',
              value: '',
            ),

            const SizedBox(height: 5),

            // Email Card
            _buildContactCard(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'olgabyte256@gmail.com',
              value: '',
            ),

            const SizedBox(height: 5),

            // WhatsApp Card
            _buildContactCard(
              icon: Icons.chat,
              title: 'WhatsApp',
              subtitle: '+233 (0) 55 323 0095',
              value: '',
            ),

            const SizedBox(height: 5),

            // Location Card
            _buildContactCard(
              icon: Icons.location_on,
              title: 'Location',
              subtitle: 'Accra, Ghana',
              value: '',
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
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.teal, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
        trailing: value.isNotEmpty
            ? Text(
                value,
                style: const TextStyle(
                  color: Color.fromARGB(255, 125, 131, 130),
                  fontSize: 12,
                ),
              )
            : null,
        onTap: () {
          // Handle contact action based on type
          switch (title) {
            case 'Email':
              // TODO: Implement email launch
              break;
            case 'WhatsApp':
              // TODO: Implement WhatsApp launch
              break;
            case 'Location':
              // TODO: Implement maps launch
              break;
          }
        },
      ),
    );
  }
}
