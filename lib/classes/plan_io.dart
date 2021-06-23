import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'plan.dart';

class PlanIO {
  //Gets current directory(+destination) and writes plans to it.
  //Uses Plan's toString() to write plans.
  //Creates a new file if it doesn't exist.
  static void writePlans(List<Plan> plans, String destination) {
    getApplicationDocumentsDirectory().then((Directory appDocDir) {
      destination = appDocDir.path + '/' + destination;
      File(destination).exists().then((bool exists) {
        String contents = '';
        for (Plan plan in plans) {
          contents += plan.toString();
        }
        if (!exists) {
          File(destination).create().then((value) {
            value.writeAsString(contents);
          });
        } else {
          File(destination).writeAsString(contents);
        }
      });
    });
  }

  //Gets current directory(+source) and reads plans from that file.
  //Returns empty list if file doesn't exist.
  static List<Plan> readPlans(String source) {
    List<Plan> plans = [];

    getApplicationDocumentsDirectory().then((Directory appDocDir) {
      source = appDocDir.path + '/' + source;
      File(source).exists().then((bool exists) {
        if (exists) {
          File(source).readAsString().then((String contents) {
            final List<String> plansStrList = contents.split('\n\n');
            plansStrList.removeAt(plansStrList.length - 1);
            for (String planStr in plansStrList) {
              plans.add(Plan(
                  planStr.substring(0, planStr.indexOf('\n')),
                  DateTime.parse(planStr.substring(
                      planStr.indexOf('\n') + 1, planStr.length))));
            }
          });
        }
      });
    });

    return plans;
  }
}
