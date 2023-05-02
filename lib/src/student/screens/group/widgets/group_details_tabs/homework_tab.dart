import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/services/group_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/helpers/date_time/start_end_datetime.dart';
import '../../../../../shared/models/enums.dart';
import '../../../../../shared/models/group_model.dart';
import '../../../../../shared/models/group_student_model.dart';
import '../../../../../shared/models/homework_model.dart';
import '../../../../../shared/theme/colors/app_colors.dart';

class HomeworkTab extends StatefulWidget {
  const HomeworkTab({Key? key, this.group, this.groupStudent})
      : super(key: key);
  final GroupModel? group;
  final GroupStudentModel? groupStudent;

  @override
  State<HomeworkTab> createState() => _HomeworkTabState();
}

class _HomeworkTabState extends State<HomeworkTab>
    with AutomaticKeepAliveClientMixin {
  Future<List<HomeworkModel>>? homeworks;
  final GroupService groupService = GroupService();
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    homeworks = getHomeworks();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Future<List<HomeworkModel>> getHomeworks() async {
    return groupService.getHomeworks(
        widget.group!.id, widget.group!.numberOfCompletedSessions!);
  }

  @override
  bool get wantKeepAlive => true;

  FutureBuilder<List<HomeworkModel>> _buildBody(BuildContext context) {
    return FutureBuilder<List<HomeworkModel>>(
      future: homeworks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<HomeworkModel>? homeworkList = snapshot.data;
          if (homeworkList!.isNotEmpty) {
            return _buildHomeworks(context, homeworkList);
          } else {
            return Center(
                child:
                    Text(AppLocalizations.of(context)!.noHomeworksInTheClass));
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: HexColor.fromHex(AppColors.accentColor),
            ),
          );
        }
      },
    );
  }

  String getDeadline(HomeworkModel homework) {
    if (homework.deadlineType == DeadlineType.session) {
      if (homework.sessionNumber != null && homework.deadline != null) {
        var result = homework.sessionNumber! + homework.deadline!;
        return AppLocalizations.of(context)!.session + ' $result';
      }
    } else {
      return getHomeworkDeadline(homework);
    }

    return '';
  }

  getHomeworkDeadline(HomeworkModel homework) {
    if (widget.groupStudent != null) {
      if (widget.groupStudent!.sessions != null) {
        String? sessionDate = widget.groupStudent!.sessions!
            .firstWhere(
                (element) => element.sessionNumber == homework.sessionNumber)
            .sessionDate;

        if (sessionDate != null && homework.deadline != null) {
          var result = addDays(sessionDate, homework.deadline);
          if (result != null) {
            return DateFormat("MMM d, yyyy").format(result);
          }
        }
      }
    }
  }

  DateTime? addDays(String? sessionDate, int? days) {
    if (sessionDate != null && days != null) {
      var date = DateTime.parse(sessionDate);
      var day = date.day + days;
      var newDate = DateTime(date.year, date.month, day);
      return newDate;
    }
    return null;
  }

  ListView _buildHomeworks(
      BuildContext context, List<HomeworkModel>? homeworks) {
    return ListView.builder(
      controller: controller,
      itemCount: homeworks!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              title: Container(
                  margin: const EdgeInsets.only(
                      left: 15, top: 25, bottom: 15, right: 15),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 1),
                              child: Text(
                                '${AppLocalizations.of(context)!.deadline}: ${homeworks[index].deadline.toString()}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ]),
                  ])),
              subtitle: Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(getDeadline(homeworks[index])),
                      ),
                      if (homeworks[index].description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(homeworks[index].description!.toString()),
                        ),
                      if (homeworks[index].grade != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(AppLocalizations.of(context)!.grade +
                              ": " +
                              homeworks[index].grade!.toString()),
                        ),
                    ],
                  )),
            ));
      },
    );
  }
}
