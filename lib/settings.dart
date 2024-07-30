import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;

  const SettingsPage({Key? key, required this.onThemeChanged})
      : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode _currentThemeMode = ThemeMode.system;
  bool _autoDeleteEnabled =
      false; // Toggle button state for auto-deleting tasks

  @override
  void initState() {
    super.initState();
    // You can load the saved theme mode and toggle state here if needed
  }

  void _handleThemeChange(ThemeMode newThemeMode) {
    setState(() {
      _currentThemeMode = newThemeMode;
    });
    widget.onThemeChanged(newThemeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Theme Mode',
            style: TextStyle(fontSize: 18.0),
          ),
          ListTile(
            title: const Text('Light'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: _currentThemeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) _handleThemeChange(value);
              },
              activeColor: Color.fromARGB(255, 255, 162, 193),
            ),
            onTap: () => _handleThemeChange(ThemeMode.light),
          ),
          ListTile(
            title: const Text('Dark'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: _currentThemeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) _handleThemeChange(value);
              },
              activeColor: Color.fromARGB(255, 255, 173, 200),
            ),
            onTap: () => _handleThemeChange(ThemeMode.dark),
          ),
          ListTile(
            title: const Text('System'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: _currentThemeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) _handleThemeChange(value);
              },
              activeColor: Color.fromARGB(255, 255, 173, 200),
            ),
            onTap: () => _handleThemeChange(ThemeMode.system),
          ),
          SizedBox(height: 20),
          Text(
            'Auto Delete Completed Tasks',
            style: TextStyle(fontSize: 18.0),
          ),
          SwitchListTile(
            value: _autoDeleteEnabled,
            onChanged: (bool value) {
              setState(() {
                _autoDeleteEnabled = value;
              });
            },
            activeColor: Color.fromARGB(255, 255, 173, 200),
            title: const Text('Enable auto-deletion'),
            subtitle:
                const Text('Tasks will be automatically deleted after a day.'),
          )
        ],
      ),
    );
  }
}
