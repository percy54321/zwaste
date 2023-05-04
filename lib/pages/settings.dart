import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          _buildHeader(context),
          _buildGeneralSettings(),
          _buildNotificationsSettings(),
          _buildPrivacySettings(),
          _buildAboutSection(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Manage your account settings and set preferences',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return ExpansionTile(
      title: const Text('General Settings'),
      children: [
        ListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Enable or disable dark mode'),
          trailing: Switch(
            value: true,
            onChanged: (value) {},
          ),
        ),
        ListTile(
          title: const Text('Language'),
          subtitle: const Text('Choose your preferred language'),
          trailing: DropdownButton<String>(
            value: 'English',
            onChanged: (newValue) {},
            items: const [
              DropdownMenuItem(child: Text('English'), value: 'English'),
              DropdownMenuItem(child: Text('Spanish'), value: 'Spanish'),
              DropdownMenuItem(child: Text('French'), value: 'French'),
            ],
          ),
        ),
        ListTile(
          title: const Text('Notifications'),
          subtitle: const Text('Enable or disable notifications'),
          trailing: Switch(
            value: false,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsSettings() {
    return ExpansionTile(
      title: const Text('Notifications Settings'),
      children: [
        ListTile(
          title: const Text('Push Notifications'),
          subtitle: const Text('Enable or disable push notifications'),
          trailing: Switch(
            value: true,
            onChanged: (value) {},
          ),
        ),
        ListTile(
          title: const Text('Email Notifications'),
          subtitle: const Text('Enable or disable email notifications'),
          trailing: Switch(
            value: false,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacySettings() {
    return ExpansionTile(
      title: const Text('Privacy Settings'),
      children: [
        ListTile(
          title: const Text('Password'),
          subtitle: const Text('Change your password'),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          title: const Text('Email Address'),
          subtitle: const Text('Change your email address'),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          title: const Text('Privacy Policy'),
          subtitle: const Text('View our privacy policy'),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Version 1.0.0',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'This is a sample settings page for demonstration purposes.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
