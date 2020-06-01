import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chuyi/widget/app_screen.dart';

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
        accentColor: Color(0xFFf9f4ec),
        backgroundColor: Color(0xFFFB7101),
        textTheme: TextTheme(bodyText1: TextStyle(color: Color(0xFF543F3d))),
        inputDecorationTheme: InputDecorationTheme(
          
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
        accentColor: Color(0xFF292623),
        platform: TargetPlatform.iOS,
        textTheme: TextTheme(bodyText1: TextStyle(color: Color(0xFFc8a588))),
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