import 'package:flutter/material.dart';
import 'package:mycel_core_mobile/mycel_core_mobile.dart';
import 'package:provider/single_child_widget.dart';

import 'screens/profile/iam_profile_screen.dart';
import 'screens/settings/iam_settings_screen.dart';

class MycelIamModule implements MycelModule {
  @override
  String get moduleId => 'iam';

  @override
  List<ModuleNavEntry> get navEntries => [
        ModuleNavEntry(
          id: 'iam_profile',
          label: 'Profile',
          icon: Icons.person,
          sortOrder: 900,
          rootBuilder: () => const IamProfileNavigator(),
        ),
        ModuleNavEntry(
          id: 'iam_settings',
          label: 'Settings',
          icon: Icons.settings,
          sortOrder: 999,
          rootBuilder: () => const IamSettingsNavigator(),
        ),
      ];

  @override
  List<SingleChildWidget> get providers => [];

  @override
  Future<void> initialize(ModuleContext context) async {
    // Module-specific imperative setup (warm caches, etc.)
  }

  @override
  void onForeground() {}

  @override
  void onBackground() {}

  @override
  void onLowMemory() {}
}
