import 'package:flutter/material.dart';
import 'main.dart';

bool isDark = false;
var themeIcon = const Icon(Icons.light_mode);
var currentTheme = ThemeMode.light;

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isSwitched = isDark;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const Text('testando'),
          FractionallySizedBox(
            child: SwitchListTile(
              secondary: themeIcon,
              value: _isSwitched,
              onChanged: (value) {
                setState(() {});
                _isSwitched = value;
                if (isDark) {
                  streamController.add(1);
                }
                if (!isDark) {
                  streamController.add(0);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
