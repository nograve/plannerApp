import 'package:flutter/material.dart';
import 'package:planner/plan_input_form.dart';
import 'package:planner/classes/plan_io.dart';
import 'package:planner/classes/plans_type.dart';
import '../classes/plan.dart';
import '../classes/options.dart';
import '../classes/plans_lists.dart';

class PendingPlanContainer extends StatefulWidget {
  PendingPlanContainer(this._plan);

  final Plan _plan;

  @override
  _PendingPlanContainerState createState() => _PendingPlanContainerState(_plan);
}

class _PendingPlanContainerState extends State<PendingPlanContainer> {
  _PendingPlanContainerState(this._plan);

  Plan _plan;
  List<Plan> _donePlans = PlansLists.donePlans;
  List<Plan> _pendingPlans = PlansLists.pendingPlans;

  //On tapping the container you can choose whether make the plan done,
  //edit it or delete it.
  void choiceAction(Container choice) {
    if (choice == Options.makeDone) {
      _donePlans.add(_plan);
      _pendingPlans.remove(_plan);
      PlanIO.writePlans(_pendingPlans, PlansType.pendings);
      PlanIO.writePlans(_donePlans, PlansType.dones);
    } else if (choice == Options.edit) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PlanInputForm(
              plan: _plan,
            );
          },
        ),
      );
    } else if (choice == Options.remove) {
      _pendingPlans.remove(_plan);
      PlanIO.writePlans(_pendingPlans, PlansType.pendings);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Evaluate remaining time
    Duration timeRemaining = _plan.dueDate.difference(DateTime.now());
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

    return PopupMenuButton<Container>(
      itemBuilder: (BuildContext context) {
        return Options.choices.map((Container choice) {
          return PopupMenuItem<Container>(
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
              padding: EdgeInsets.only(bottom: 5),
              alignment: Alignment.topLeft,
              child: Text(
                _plan.task,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                timeRemainder,
                style: TextStyle(
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
