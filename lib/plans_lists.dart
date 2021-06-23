import 'plan.dart';
import 'plan_io.dart';
import 'plans_type.dart';

//Main plans lists of the application
class PlansLists {
  static List<Plan> pendingPlans = PlanIO.readPlans(PlansType.pendings);
  static List<Plan> donePlans = PlanIO.readPlans(PlansType.dones);
  static List<Plan> undonePlans = PlanIO.readPlans(PlansType.undones);
}
