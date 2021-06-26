import 'package:flutter/material.dart';

//Options that appear when you tap on a pending plan container
class Options {
  static Row makeDone = Row(
      children: const [
        Icon(
          Icons.done,
          color: Colors.green,
        ),
        Text('Done!'),
      ],
    );
  static Row edit = Row(
      children: [
        Icon(
          Icons.edit,
          color: Colors.brown[700],
        ),
        const Text('Edit'),
      ],
  );
  static Row remove = Row(
      children: const [
        Icon(
          Icons.delete,
          color: Colors.red,
        ),
        Text('Remove'),
      ],
  );

  static List<Row> choices = <Row>[
    makeDone,
    edit,
    remove,
  ];
}
