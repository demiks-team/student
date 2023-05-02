import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/models/enums.dart';
import 'package:student/src/shared/services/group_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/models/group_model.dart';
import '../../../../../shared/models/group_student_model.dart';
import '../../../../../shared/models/session_summary_model.dart';
import '../../../../../shared/theme/colors/app_colors.dart';

class AttendanceGroupTab extends StatefulWidget {
  const AttendanceGroupTab({Key? key, this.group, this.groupStudent})
      : super(key: key);
  final GroupModel? group;
  final GroupStudentModel? groupStudent;

  @override
  State<AttendanceGroupTab> createState() => _AttendanceGroupTabState();
}

class _AttendanceGroupTabState extends State<AttendanceGroupTab>
    with AutomaticKeepAliveClientMixin {
  GroupStudentModel? groupStudent;
  final GroupService groupService = GroupService();
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    groupStudent = widget.groupStudent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildSessionSummary(context, groupStudent!.sessions),
    );
  }

  String getStringSessionNumber(SessionSummaryModel session) {
    String result = "";

    if (session.sessionStatus != GroupSessionStatus.cancelled &&
        session.sessionNumber != null) {
      result = session.sessionNumber.toString() +
          "/" +
          widget.group!.numberOfSessions.toString();
    } else if (session.sessionStatus == GroupSessionStatus.cancelled) {
      result = AppLocalizations.of(context)!.cancelled;
    } else if (session.sessionStatus == GroupSessionStatus.requested) {
      result = AppLocalizations.of(context)!.requested;
    }

    if (session.isCancellationRequested == true) {
      if (session.sessionStatus == GroupSessionStatus.cancelled) {
        result += "\n" + AppLocalizations.of(context)!.byStudent;
      } else {
        result += "\n" + AppLocalizations.of(context)!.cancellationRequested;
      }
    }

    return result;
  }

  @override
  bool get wantKeepAlive => true;

  ListView _buildSessionSummary(
      BuildContext context, List<SessionSummaryModel>? groupLearningMaterials) {
    return ListView.builder(
      controller: controller,
      itemCount: groupLearningMaterials!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              title: Container(
                  margin: const EdgeInsets.only(
                      left: 15, top: 25, bottom: 15, right: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(top: 1),
                                  child: Text(
                                    DateFormat("MMMMd").format(DateTime.parse(
                                            groupLearningMaterials[index]
                                                .sessionDate!)
                                        .toLocal()),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              if (groupLearningMaterials[index].status == 0)
                                Icon(
                                  Icons.check,
                                  color:
                                      HexColor.fromHex(AppColors.primaryColor),
                                  size: 30,
                                ),
                              if (groupLearningMaterials[index].status == 1)
                                Icon(
                                  Icons.snooze,
                                  color:
                                      HexColor.fromHex(AppColors.accentColor),
                                  size: 30,
                                ),
                              if (groupLearningMaterials[index].status == 2)
                                Icon(
                                  Icons.alarm,
                                  color:
                                      HexColor.fromHex(AppColors.accentColor),
                                  size: 30,
                                ),
                              if (groupLearningMaterials[index].status == 3)
                                const Icon(
                                  Icons.block,
                                  color: Colors.red,
                                  size: 30,
                                )
                            ]),
                        Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                                getStringSessionNumber(
                                    groupLearningMaterials[index]),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)))
                      ])),
              subtitle: Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (groupLearningMaterials[index].notesForStudent != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(groupLearningMaterials[index]
                              .notesForStudent!
                              .toString()),
                        ),
                      if (groupLearningMaterials[index].teacherNote != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(groupLearningMaterials[index]
                              .teacherNote!
                              .toString()),
                        ),
                    ],
                  )),
            ));
      },
    );
  }
}
