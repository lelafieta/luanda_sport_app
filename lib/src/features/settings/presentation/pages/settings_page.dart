import 'package:flutter/material.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/pages/team_setting_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Widget content = Container();
    int selectedOption = 0;

    switch (selectedOption) {
      case 0:
        content = TeamSettingPage();
        break;
      case 1:
        content = Center(child: Text('Option 1 Selected'));
        break;
      case 2:
        content = Center(child: Text('Option 2 Selected'));
        break;
      case 3:
        content = Center(child: Text('Option 3 Selected'));
        break;
      default:
        content = Center(child: Text('Default Option'));
    }
    return Scaffold(
      body: content,
    );
  }
}
