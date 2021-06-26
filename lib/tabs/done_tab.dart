import 'package:flutter/material.dart';
import 'package:planner/classes/plan_io.dart';
import 'package:planner/classes/plans_type.dart';
import '../classes/plan.dart';
import '../classes/plans_lists.dart';
import '../containers/done_plan_container.dart';

class DoneTab extends StatefulWidget {
  @override
  _DoneTabState createState() => _DoneTabState();
}

class _DoneTabState extends State<DoneTab> {
  final List<Plan> _donePlans = PlansLists.donePlans;

  void _clearPlans() {
    setState(() {
      _donePlans.clear();
      PlanIO.writePlans(_donePlans, PlansType.dones);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: _donePlans.length,
              itemBuilder: (BuildContext context, int index) {
                return DonePlanContainer(_donePlans[index]);
              }),
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all(const ContinuousRectangleBorder()),
              minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 50))),
          onPressed: _clearPlans,
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
