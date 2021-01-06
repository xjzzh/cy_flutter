import 'package:chuyi/view/detail/detail_page.dart';
import 'package:chuyi/view/user/login_page.dart';
import 'package:flutter/material.dart';


void homeRouter(BuildContext context, dynamic id) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailPage(cookId: id),
    ),
  );
}

Route loginRoute(){
  /// widget: https://flutter.dev/docs/cookbook/animation/page-route-animation
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    }
  );
}

class LoginRouter<T> extends MaterialPageRoute<T> {
  LoginRouter({ WidgetBuilder builder, RouteSettings settings })
    : super(builder: builder, settings: settings);
  
  @override
  Widget buildTransitions(BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      
      return SlideTransition(
        position: animation.drive(tween),
        child: child
      );
    }
}