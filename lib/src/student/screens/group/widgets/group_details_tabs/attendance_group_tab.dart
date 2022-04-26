import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/services/group_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/helpers/hex_color.dart';
import '../../../../../shared/models/group_model.dart';
import '../../../../../shared/models/group_student_model.dart';
import '../../../../../shared/models/session_summary_model.dart';
import '../../../../../shared/theme/colors/demiks_colors.dart';
import '../../../../../shared/services/group_service.dart';

class AttendanceGroupTab extends StatefulWidget {
  const AttendanceGroupTab({Key? key, this.group}) : super(key: key);
  final GroupModel? group;

  @override
  State<AttendanceGroupTab> createState() => _AttendanceGroupTabState();
}

class _AttendanceGroupTabState extends State<AttendanceGroupTab>
    with AutomaticKeepAliveClientMixin {
  Future<GroupStudentModel>? groupStudentModel;
  final GroupService groupService = GroupService();

  @override
  void initState() {
    super.initState();
    groupStudentModel = getGroupStudent();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Future<GroupStudentModel> getGroupStudent() async {
    return groupService.getStudentAttendances(widget.group!.id);
  }

  @override
  bool get wantKeepAlive => true;

  FutureBuilder<List<SessionSummaryModel>> _buildBody(BuildContext context) {
    return FutureBuilder<List<SessionSummaryModel>>(
      future: groupStudentModel!.then((value) => value.sessions!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<SessionSummaryModel>? sessionSummary = snapshot.data;
          if (sessionSummary!.isNotEmpty) {
            return _buildSessionSummary(context, sessionSummary);
          } else {
            return Center(
                child: Text(AppLocalizations.of(context)!.noSessionInTheClass));
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: HexColor.fromHex(DemiksColors.accentColor),
            ),
          );
        }
      },
    );
  }

  ListView _buildSessionSummary(
      BuildContext context, List<SessionSummaryModel>? groupLearningMaterials) {
    return ListView.builder(
      itemCount: groupLearningMaterials!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              title: Container(
                  margin: const EdgeInsets.only(left: 8, top: 5),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 1),
                              child: Text(
                                DateFormat("MMMMd").format(DateTime.parse(
                                    groupLearningMaterials[index]
                                        .sessionDate!)),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          if (groupLearningMaterials[index].status == 0)
                            Icon(
                              Icons.check,
                              color:
                                  HexColor.fromHex(DemiksColors.primaryColor),
                              size: 30,
                            ),
                          if (groupLearningMaterials[index].status == 1)
                            Icon(
                              Icons.snooze,
                              color: HexColor.fromHex(DemiksColors.accentColor),
                              size: 30,
                            ),
                          if (groupLearningMaterials[index].status == 2)
                            Icon(
                              Icons.alarm,
                              color: HexColor.fromHex(DemiksColors.accentColor),
                              size: 30,
                            ),
                          if (groupLearningMaterials[index].status == 3)
                            const Icon(
                              Icons.block,
                              color: Colors.red,
                              size: 30,
                            )
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                              groupLearningMaterials[index]
                                      .sessionNumber
                                      .toString() +
                                  "/" +
                                  widget.group!.numberOfSessions.toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)))
                    ])
                  ])),
              subtitle: Container(
                  margin: const EdgeInsets.only(left: 20, top: 5),
                  child: Column(
                    children: [
                      if (groupLearningMaterials[index].notesForStudent != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(groupLearningMaterials[index]
                                    .notesForStudent!
                                    .toString()),
                              ),
                            ]),
                      if (groupLearningMaterials[index].teacherNote != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(groupLearningMaterials[index]
                                    .teacherNote!
                                    .toString()),
                              ),
                            ]),
                    ],
                  )),
            ));
      },
    );
  }
}
