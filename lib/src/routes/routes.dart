import 'package:flutter/material.dart';
import 'package:smpark/src/pages/list_page.dart';


Map<String,WidgetBuilder> getApplicationRoutes() {
    return <String,WidgetBuilder> {
        '/'         : (BuildContext context) => ListPage(),
    };

}