import 'package:cy_flutter/view/detail/detail_page.dart';
import 'package:flutter/material.dart';


void homeRouter(BuildContext context, dynamic id) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => DetailPage(id),
    ));
  }