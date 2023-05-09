import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_mnagment/services/theme_services.dart';
import '../services/notification_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.checkForNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
          child: ElevatedButton(
        child: const Text('Show notifications'),
        onPressed: () {},
      )),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          // NotifyHelper().showNotification();
          notifyHelper.showNotification();
        },
        child: Icon(
          Icons.nightlight_rounded,
          size: 20,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          size: 20,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
