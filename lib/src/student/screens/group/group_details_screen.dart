import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../shared/helpers/colors/hex_color.dart';
import '../../../shared/helpers/colors/material_color.dart';
import '../../../shared/models/evaluation_criteria_group_student_model.dart';
import '../../../shared/models/group_model.dart';
import '../../../shared/models/group_student_model.dart';
import '../../../shared/services/group_service.dart';
import '../../../shared/theme/colors/app_colors.dart';
import 'widgets/group_details_tabs/attendance_group_tab.dart';
import 'widgets/group_details_tabs/group_material_tab.dart';
import 'widgets/group_details_tabs/group_details_tab.dart';
import 'widgets/group_details_tabs/homework_tab.dart';
import 'widgets/group_details_tabs/quiz_and_grades_tab.dart';

class GroupDetailsScreen extends StatefulWidget {
  final int groupId;

  const GroupDetailsScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  GroupModel? group;
  GroupStudentModel? groupStudent;
  EvaluationCriteriaGroupStudentModel? evaluationCriteriaGroupStudent;
  final GroupService groupService = GroupService();

  @override
  initState() {
    super.initState();
    loadClass();
    loadEvaluationCriteria();
    loadGroupSessions();
  }

  Future<void> loadClass() async {
    Future<GroupModel> futureClass = groupService.getGroup(widget.groupId);
    await futureClass.then((g) {
      setState(() {
        group = g;
      });
    });
  }

  Future<void> loadEvaluationCriteria() async {
    Future<EvaluationCriteriaGroupStudentModel> futureClass =
        groupService.getEvaluationCriteria(widget.groupId);
    await futureClass.then((ec) {
      setState(() {
        evaluationCriteriaGroupStudent = ec;
      });
    });
  }

  Future<void> loadGroupSessions() async {
    Future<GroupStudentModel> futureClass =
        groupService.getStudentAttendances(widget.groupId);
    await futureClass.then((gs) {
      setState(() {
        groupStudent = gs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (group != null && evaluationCriteriaGroupStudent != null) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
            Locale('fr', ''),
          ],
          theme: ThemeData(
              primarySwatch: buildMaterialColor(const Color(0xffffffff))),
          home: DefaultTabController(
              length: 4, // 5
              child: Scaffold(
                appBar: AppBar(
                  title: Text(group!.title.toString()),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: HexColor.fromHex(AppColors.accentColor)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  iconTheme: IconThemeData(
                      color: HexColor.fromHex(AppColors.accentColor)),
                  bottom: TabBar(
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    indicatorColor: HexColor.fromHex(AppColors.primaryColor),
                    labelColor: Colors.grey,
                    tabs: <Widget>[
                      Tab(text: AppLocalizations.of(context)!.details),
                      Tab(text: AppLocalizations.of(context)!.attendance),
                      Tab(text: AppLocalizations.of(context)!.learningMaterial),
                      // Tab(text: AppLocalizations.of(context)!.quizGrades),
                      Tab(text: AppLocalizations.of(context)!.homework),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    GroupDetailsTab(
                        group: group!,
                        evaluationCriteriaGroupStudent:
                            evaluationCriteriaGroupStudent!),
                    AttendanceGroupTab(
                        group: group, groupStudent: groupStudent),
                    GroupMaterialTab(group: group),
                    // QuizAndGradesTab(group: group),
                    HomeworkTab(group: group, groupStudent: groupStudent),
                  ],
                ),
              )));
    } else {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          color: HexColor.fromHex(AppColors.accentColor),
        ),
      );
    }
  }
}
