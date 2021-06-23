import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planner/classes/plan_io.dart';
import '../classes/plans_type.dart';
import '../classes/plan.dart';
import '../containers/pending_plan_container.dart';
import '../plan_input_form.dart';
import '../classes/plans_lists.dart';

class PendingTab extends StatefulWidget {
  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  List<Plan> _pendingPlans = PlansLists.pendingPlans;
  List<Plan> _undonePlans = PlansLists.undonePlans;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    //Update the list of pending plans
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _pendingPlans.removeWhere((plan) {
          //Delete dued plans and move them to undone
          if (DateTime.now().isAfter(plan.dueDate)) {
            _undonePlans.add(plan);
            PlanIO.writePlans(_pendingPlans, PlansType.pendings);
            PlanIO.writePlans(_undonePlans, PlansType.undones);
            return true;
          }
          return false;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    //Stop updating the list if this Tab is no longer displayed
    _timer.cancel();
  }

  //Creates a form to create pending plan
  void _onPlusButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PlanInputForm();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: _pendingPlans.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: PendingPlanContainer(_pendingPlans[index]),
                );
              }),
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all(ContinuousRectangleBorder()),
              minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 50))),
          onPressed: _onPlusButtonPressed,
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
