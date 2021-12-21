import 'package:flutter/material.dart';
import 'package:persistent_theme/MyDrawer.dart';
import 'dart:async';

StreamController<bool> streamController = StreamController<bool>();

void main() => runApp(MyApp(streamController.stream));

class MyApp extends StatefulWidget {
  const MyApp(this.stream);
  final Stream<bool> stream;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSwitched = isDark;
  @override
  void initState() {
    super.initState();
    widget.stream.listen((value) {
      mySetState(value);
    });
  }

  void mySetState(value) {
    setState(() {
      if (isDark) {
        currentTheme = ThemeMode.light;
        themeIcon = const Icon(Icons.light_mode);
        isDark = false;
      }
      else if (!isDark) {
        currentTheme = ThemeMode.dark;
        themeIcon = const Icon(Icons.dark_mode);
        isDark = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //key: const Key('themerState'),
      title: 'Simple Theme',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
      ),
      themeMode: currentTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Simple Theme"),
        ),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            Container(
              alignment: const Alignment(0, -0.5),
              child: FractionallySizedBox(
                widthFactor: 0.3,
                child: SwitchListTile(
                  secondary: themeIcon,
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(
                      () {
                        _isSwitched = value;
                        if (isDark) {
                          currentTheme = ThemeMode.light;
                          themeIcon = const Icon(Icons.light_mode);
                          isDark = false;
                        }
                        if (!isDark) {
                          currentTheme = ThemeMode.dark;
                          themeIcon = const Icon(Icons.dark_mode);
                          isDark = true;
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            Text('isDark = $isDark')
          ],
        ),
      ),
    );
  }
}
