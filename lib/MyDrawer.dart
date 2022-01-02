import 'package:flutter/material.dart';
import 'main.dart';

var themeIcon = const Icon(Icons.light_mode);
var currentTheme = ThemeMode.light;

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isSwitched = isDark!;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      //width: MediaQuery.of(context).size.width * 0.50,
      child: Drawer(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           const DrawerHeader(
              child:  Center(
                child: Text('titulo!!', style: TextStyle(
                  fontSize: 30
                ),),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: SwitchListTile(
                secondary: themeIcon,
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {});
                  _isSwitched = value;
                  changeTheme();
                  themeController.add(value);
                  saveCurrentTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
