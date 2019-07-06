import 'package:flutter/material.dart';

class Hint  extends StatelessWidget {
  final String faunaName;
  Hint.loadFauna({this.faunaName}):super();

  @override
  Widget build(BuildContext context) {
    return new IconButton(icon: new Icon(Icons.help_outline), onPressed: (){
      final snackBar = SnackBar(content: Text('Thats a $faunaName'));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }
}