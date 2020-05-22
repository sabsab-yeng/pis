
import 'package:pis/enum/enum.dart';
import 'package:pis/models/job.dart';
class JobDetialBloc{
  JobOrder _jobOrder;
  JobOrder get jobOrder => _jobOrder;

  JobStatus getJobStatus() {
    return jobOrder.getJobStatus();
  }

}