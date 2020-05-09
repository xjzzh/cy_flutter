import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cy_flutter/widget/app_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(ChuYiApp()));
}

class ChuYiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.light,
        platform: TargetPlatform.iOS,
        primaryColor: Colors.white,
        canvasColor: Color(0xFFF4EDE0),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
        platform: TargetPlatform.iOS,
      ),
      home: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,// 是否重新布局
          body: AppScreen(),
        ),
      ),
    );
  }
}