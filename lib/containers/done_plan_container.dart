import 'package:flutter/material.dart';
import '../classes/plan.dart';

class DonePlanContainer extends StatelessWidget {
  DonePlanContainer(this.plan);
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    //Make the date look nicer
    String dueDate =
        '${plan.dueDate.month}/${plan.dueDate.day}/${plan.dueDate.year} ${plan.dueDate.hour}:${plan.dueDate.minute}';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 5),
            alignment: Alignment.topLeft,
            child: Text(
              plan.task,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              dueDate,
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
