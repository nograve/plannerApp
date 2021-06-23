import 'package:flutter/material.dart';

//Options that appear when you tap on a pending plan container
class Options {
  static Container makeDone = Container(
    child: Row(
      children: [
        Icon(
          Icons.done,
          color: Colors.green,
        ),
        Text('Done!'),
      ],
    ),
  );
  static Container edit = Container(
    child: Row(
      children: [
        Icon(
          Icons.edit,
          color: Colors.brown[700],
        ),
        Text('Edit'),
      ],
    ),
  );
  static Container remove = Container(
    child: Row(
      children: [
        Icon(
          Icons.delete,
          color: Colors.red,
        ),
        Text('Remove'),
      ],
    ),
  );

  static List<Container> choices = <Container>[
    makeDone,
    edit,
    remove,
  ];
}
