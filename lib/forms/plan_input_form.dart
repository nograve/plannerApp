import 'package:flutter/material.dart';
import 'package:planner/classes/plan_io.dart';
import 'package:planner/classes/plans_type.dart';
import '../classes/plan.dart';
import '../classes/plans_lists.dart';

class PlanInputForm extends StatefulWidget {
  const PlanInputForm({this.plan});

  final Plan plan;

  @override
  _PlanInputFormState createState() => _PlanInputFormState();
}

class _PlanInputFormState extends State<PlanInputForm> {
  _PlanInputFormState({this.plan}) {
    //Remember if plan is new created or edited.
    if (plan == null) {
      plan = Plan('', DateTime.now().add(const Duration(minutes: 10)));
      _isEditing = false;
    } else {
      _isEditing = true;
    }
    _tempDueDate = plan.dueDate;
    _tempDueTime = TimeOfDay.fromDateTime(plan.dueDate); //Time like 19:30
    _tempTask = plan.task;
  }

  Plan plan;
  final _formKey = GlobalKey<FormState>(); //Key, required for form
  DateTime _tempDueDate;
  TimeOfDay _tempDueTime;
  String _tempTask;
  String _hour;
  String _minute;
  String _time;
  bool _isEditing;
  final List<Plan> _pendingPlans = PlansLists.pendingPlans;
  @override
  Widget build(BuildContext context) {
    //Make time look nicer when hour or minute less than 10
    if (_tempDueTime.hour.toString().length == 1) {
      _hour = '0${_tempDueDate.hour}';
    } else {
      _hour = _tempDueTime.hour.toString();
    }

    if (_tempDueTime.minute.toString().length == 1) {
      _minute = '0${_tempDueDate.minute}';
    } else {
      _minute = _tempDueTime.minute.toString();
    }

    _time = '$_hour:$_minute';
    ////////////////////////////////////
    return MaterialApp(
      home: Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Task description
                TextFormField(
                  initialValue: _tempTask,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.edit),
                    hintText: 'Ex. Make a coffee',
                    labelText: 'Task description',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter some text.';
                    }
                    _tempTask = value;
                    return null;
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      //Date picker
                      const Text(
                        'Date:',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        '${_tempDueDate.month}/${_tempDueDate.day}/${_tempDueDate.year}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      TextButton(
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: _tempDueDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 3650),
                              )).then((date) {
                            setState(() {
                              if (date != null) {
                                _tempDueDate = date;
                              }
                            });
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.calendar_today),
                            Text('Pick the date'),
                          ],
                        ),
                      ),
                      //Time picker
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Time:',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              _time,
                              style: const TextStyle(fontSize: 24),
                            ),
                            TextButton(
                              onPressed: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: _tempDueTime)
                                    .then((time) {
                                  setState(() {
                                    if (time != null) {
                                      if (_tempDueDate.day ==
                                          DateTime.now().day) {
                                        if (time.hour > TimeOfDay.now().hour ||
                                            (time.hour ==
                                                    TimeOfDay.now().hour &&
                                                time.minute >
                                                    TimeOfDay.now().minute)) {
                                          _tempDueTime = time;
                                        }
                                      } else {
                                        _tempDueTime = time;
                                      }
                                    }
                                  });
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.timer),
                                  Text('Pick the time'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Submit button
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {
                      //Validates the whole form, prints error if need to correct
                      //or works with plan if it's valid
                      if (_formKey.currentState.validate()) {
                        _tempDueDate = DateTime(
                            _tempDueDate.year,
                            _tempDueDate.month,
                            _tempDueDate.day,
                            _tempDueTime.hour,
                            _tempDueTime.minute);
                        plan.dueDate = _tempDueDate;
                        plan.task = _tempTask;
                        if (!_isEditing) {
                          _pendingPlans.add(plan);
                        }
                        PlanIO.writePlans(_pendingPlans, PlansType.pendings);
                        Navigator.pop(context); //Return to home page
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 60))),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
