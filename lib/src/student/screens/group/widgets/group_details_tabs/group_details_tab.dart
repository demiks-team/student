import 'package:flutter/material.dart';
import 'package:student/src/shared/models/evaluation_criteria_group_student_model.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/models/group_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/services/group_service.dart';
import '../../../../../shared/theme/colors/app_colors.dart';

class GroupDetailsTab extends StatefulWidget {
  const GroupDetailsTab(
      {Key? key,
      required this.group,
      required this.evaluationCriteriaGroupStudent})
      : super(key: key);

  final GroupModel group;
  final EvaluationCriteriaGroupStudentModel evaluationCriteriaGroupStudent;

  @override
  State<GroupDetailsTab> createState() => _GroupDetailsTabState();
}

class _GroupDetailsTabState extends State<GroupDetailsTab> {
  final GroupService groupService = GroupService();

  finalEvaluationText(String? result, String? passCondition) {
    String? resultPassCondition = "";
    if (result == null && passCondition == null) {
      resultPassCondition = "?";
    } else {
      if (result != null && passCondition == null) {
        resultPassCondition = result;
      } else if (result == null && passCondition != null) {
        resultPassCondition = "?/" + passCondition;
      } else if (result != null && passCondition != null) {
        resultPassCondition = result + "/" + passCondition;
      }
    }
    return resultPassCondition;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: Card(
            margin: const EdgeInsets.only(top: 30),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(left: 10, right: 10),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  // if ((widget.group.adminReviewIsDone != null &&
                  //         widget.group.adminReviewIsDone == true) &&
                  //     (widget.evaluationCriteriaGroupStudent
                  //                 .groupEnrollment !=
                  //             null &&
                  //         widget
                  //                 .evaluationCriteriaGroupStudent
                  //                 .groupEnrollment!
                  //                 .canStudentPrintCertificate !=
                  //             null &&
                  //         widget
                  //                 .evaluationCriteriaGroupStudent
                  //                 .groupEnrollment!
                  //                 .canStudentPrintCertificate ==
                  //             true))
                  //   IconButton(
                  //     icon: Icon(Icons.workspace_premium,
                  //         color:
                  //             HexColor.fromHex(AppColors.accentColor)),
                  //     onPressed: () async => {
                  //       await groupService
                  //           .getCertificateStudent(widget.group.id)
                  //     },
                  //   ),
                  // if ((widget.group.adminReviewIsDone != null &&
                  //         widget.group.adminReviewIsDone == true) &&
                  //     (widget.evaluationCriteriaGroupStudent
                  //                 .groupEnrollment !=
                  //             null &&
                  //         widget
                  //                 .evaluationCriteriaGroupStudent
                  //                 .groupEnrollment!
                  //                 .canStudentPrintReportCard !=
                  //             null &&
                  //         widget
                  //                 .evaluationCriteriaGroupStudent
                  //                 .groupEnrollment!
                  //                 .canStudentPrintReportCard ==
                  //             true))
                  //   IconButton(
                  //     icon: Icon(Icons.badge,
                  //         color:
                  //             HexColor.fromHex(AppColors.accentColor)),
                  //     onPressed: () async => {
                  //       await groupService
                  //           .exportReportCardStudent(widget.group.id)
                  //     },
                  //   ),
                  // ]),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(widget.group.school!.name.toString()),
                  ),
                  if (widget.group.teacher != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(widget.group.teacher!.fullName.toString()),
                    ),
                  if (widget.group.course != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(widget.group.course!.name.toString()),
                    ),
                  if (widget.group.room != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(widget.group.room!.title.toString()),
                    ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                  ),
                ]))),
      ),
      if (widget.evaluationCriteriaGroupStudent.evaluationCriteriaGroup!
              .isNotEmpty &&
          (widget.group.adminReviewIsDone != null &&
              widget.group.adminReviewIsDone == true))
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Card(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    Text(
                        AppLocalizations.of(context)!
                            .finalEvaluation
                            .toString(),
                        style: const TextStyle(fontSize: 20)),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                    ),
                    for (var ec in widget.evaluationCriteriaGroupStudent
                        .evaluationCriteriaGroup!)
                      Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: ec.title.toString() + ":  ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: (finalEvaluationText(
                                        ec.result, ec.passCondition)))
                              ])),
                              const Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                              ),
                            ],
                          ))
                  ]))),
        )
    ]));
  }
}
