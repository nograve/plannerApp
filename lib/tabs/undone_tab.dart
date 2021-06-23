import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planner/classes/plan_io.dart';
import 'package:planner/classes/plans_type.dart';
import '../classes/plan.dart';
import '../classes/plans_lists.dart';
import '../containers/undone_plan_container.dart';

class UndoneTab extends StatefulWidget {
  @override
  _UndoneTabState createState() => _UndoneTabState();
}

class _UndoneTabState extends State<UndoneTab> {
  List<Plan> _pendingPlans = PlansLists.pendingPlans;
  List<Plan> _undonePlans = PlansLists.undonePlans;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    //Constantly updates undone tasks
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

  void _clearPlans() {
    setState(() {
      _undonePlans.clear();
      PlanIO.writePlans(_undonePlans, PlansType.undones);
    });
  }

  @override
  void dispose() {
    super.dispose();

    //Stop the list updating
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: _undonePlans.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: UndonePlanContainer(_undonePlans[index]),
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
          onPressed: _clearPlans,
          child: Icon(Icons.delete),
        ),
      ],
    );
  }
}
