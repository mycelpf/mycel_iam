import 'package:flutter/material.dart';
import 'package:mycel_core_mobile/mycel_core_mobile.dart';
import 'package:provider/provider.dart';

/// IAM Settings screen — placeholder.
class IamSettingsScreen extends StatelessWidget {
  const IamSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthState>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
            subtitle: const Text('System default'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Enabled'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: theme.colorScheme.error),
            title: Text(
              'Sign Out',
              style: TextStyle(color: theme.colorScheme.error),
            ),
            onTap: () => auth.clear(),
          ),
        ],
      ),
    );
  }
}

/// Navigator wrapper for the Settings tab.
class IamSettingsNavigator extends StatelessWidget {
  const IamSettingsNavigator({super.key});

  @override
  Widget build(BuildContext context) => const IamSettingsScreen();
}
