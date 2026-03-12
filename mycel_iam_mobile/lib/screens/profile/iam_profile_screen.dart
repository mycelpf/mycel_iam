import 'package:flutter/material.dart';
import 'package:mycel_core_mobile/mycel_core_mobile.dart';
import 'package:provider/provider.dart';

/// IAM Profile screen — placeholder.
class IamProfileScreen extends StatelessWidget {
  const IamProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthState>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              auth.email ?? 'User',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Authenticated',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Navigator wrapper for the Profile tab.
class IamProfileNavigator extends StatelessWidget {
  const IamProfileNavigator({super.key});

  @override
  Widget build(BuildContext context) => const IamProfileScreen();
}
