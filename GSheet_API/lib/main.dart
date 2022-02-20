import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsheet_api/api/sheets_api.dart';
import 'package:gsheet_api/widget/button_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetsAPI.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Akanksha Chaudhari';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.all(32),
        child: buttonWidget(
          text: 'trigger',
          onClicked: () async {},
        ),
      ),
    );
  }
}
