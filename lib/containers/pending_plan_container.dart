import 'package:flutter/material.dart';
import 'package:planner/classes/plan_io.dart';
import 'package:planner/classes/plans_type.dart';
import 'package:planner/forms/plan_input_form.dart';

import '../classes/options.dart';
import '../classes/plan.dart';
import '../classes/plans_lists.dart';

class PendingPlanContainer extends StatefulWidget {
  const PendingPlanContainer(this._plan);

  final Plan _plan;

  @override
  _PendingPlanContainerState createState() => _PendingPlanContainerState();
}

class _PendingPlanContainerState extends State<PendingPlanContainer> {
  final List<Plan> _donePlans = PlansLists.donePlans;
  final List<Plan> _pendingPlans = PlansLists.pendingPlans;

  //On tapping the container you can choose whether make the plan done,
  //edit it or delete it.
  void choiceAction(Row choice) {
    if (choice == Options.makeDone) {
      _donePlans.add(widget._plan);
      _pendingPlans.remove(widget._plan);
      PlanIO.writePlans(_pendingPlans, PlansType.pendings);
      PlanIO.writePlans(_donePlans, PlansType.dones);
    } else if (choice == Options.edit) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PlanInputForm(
              plan: widget._plan,
            );
          },
        ),
      );
    } else if (choice == Options.remove) {
      _pendingPlans.remove(widget._plan);
      PlanIO.writePlans(_pendingPlans, PlansType.pendings);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Evaluate remaining time
    final Duration timeRemaining = widget._plan.dueDate.difference(DateTime.now());
    String timeRemainder = '';
    if (timeRemaining.inDays > 0) {
      timeRemainder =
          'Due in ${timeRemaining.inDays} days, ${timeRemaining.inHours % 24} hours, and ${timeRemaining.inMinutes % 60} minutes.';
    } else if (timeRemaining.inHours > 0) {
      timeRemainder =
          'Due in ${timeRemaining.inHours % 24} hours, and ${timeRemaining.inMinutes % 60} minutes.';
    } else if (timeRemaining.inSeconds > 0) {
      timeRemainder = 'Due in ${timeRemaining.inMinutes % 60} minutes.';
    }

    return PopupMenuButton<Row>(
      itemBuilder: (BuildContext context) {
        return Options.choices.map((Row choice) {
          return PopupMenuItem<Row>(
            value: choice,
            child: choice,
          );
        }).toList();
      },
      onSelected: choiceAction,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              alignment: Alignment.topLeft,
              child: Text(
                widget._plan.task,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                timeRemainder,
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
