import 'package:flutter/material.dart';
import 'package:persistent_theme/MyDrawer.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: voltar ao código enviando valor bool no stream

void main() {
  //SharedPreferences.setMockInitialValues(values);

  runApp(MyApp(themeController.stream));
}

bool? isDark = false;

StreamController<bool> themeController = StreamController<bool>();

Map<String, bool> values = <String, bool>{'isDark': true};

void changeTheme() {
  if (isDark!) {
    currentTheme = ThemeMode.light;
    themeIcon = const Icon(Icons.light_mode);
    isDark = false;
  } else if (!isDark!) {
    currentTheme = ThemeMode.dark;
    themeIcon = const Icon(Icons.dark_mode);
    isDark = true;
  }
}

void setTheme() {
  if (isDark!) {
    currentTheme = ThemeMode.dark;
    themeIcon = const Icon(Icons.dark_mode);
  } else if (!isDark!) {
    currentTheme = ThemeMode.light;
    themeIcon = const Icon(Icons.light_mode);
  }
}

void getCurrentTheme() async {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  prefs.then((prefs) {
    print('pegando tema');
    isDark = prefs.getBool('isDark');
    print('peguei, é $isDark');
  });
}

void getTheme() async {
  bool? darkS;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  prefs.then((prefs) {
    print('pegando tema');
    darkS = prefs.getBool('isDark');
    print('peguei, é $darkS');
    isDark = darkS;
  });
}

void saveCurrentTheme() async {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  prefs.then((prefs) {
    print('salvando tema');
    prefs.setBool('isDark', isDark!);
    bool? teste = prefs.getBool('isDark');
    print('setei como $teste');
  });
}

class MyApp extends StatefulWidget {
  const MyApp(this.stream);
  final Stream<bool> stream;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSwitched = isDark!;
  @override
  void initState() {
    super.initState();
    widget.stream.listen((value) {
      mySetState();
    });
  }

  void mySetState() {
    setState(() {});
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getTheme();
            setTheme();
            setState(() {});
          },
        ),
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
                        _isSwitched = isDark!;
                        if (isDark!) {
                          currentTheme = ThemeMode.light;
                          themeIcon = const Icon(Icons.light_mode);
                          isDark = false;
                        }
                        // funciona se for else
                        else if (!isDark!) {
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
            Text('isDark = $isDark'),
          ],
        ),
      ),
    );
  }
}
