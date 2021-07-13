import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("<DAME UN BESO EN LA COLA>\ndijo el burro",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center),
      ),
    );
  }
}
