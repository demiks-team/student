import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../shared/helpers/colors/hex_color.dart';
import '../../../shared/helpers/colors/material_color.dart';
import '../../../shared/models/group_model.dart';
import '../../../shared/services/group_service.dart';
import '../../../shared/theme/colors/demiks_colors.dart';
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
  GroupModel? groupModel;
  final GroupService groupService = GroupService();

  @override
  initState() {
    super.initState();
    loadClass();
  }

  void loadClass() async {
    Future<GroupModel> futureClass = groupService.getGroup(widget.groupId);
    await futureClass.then((cm) {
      setState(() {
        groupModel = cm;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (groupModel != null) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('es', ''),
            Locale('fr', ''),
          ],
          theme: ThemeData(
              primarySwatch: buildMaterialColor(const Color(0xffffffff))),
          home: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(groupModel!.title.toString()),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: HexColor.fromHex(DemiksColors.accentColor)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  iconTheme: IconThemeData(
                      color: HexColor.fromHex(DemiksColors.accentColor)),
                  bottom: TabBar(
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    indicatorColor: HexColor.fromHex(DemiksColors.primaryColor),
                    labelColor: Colors.grey,
                    tabs: <Widget>[
                      Tab(text: AppLocalizations.of(context)!.details),
                      Tab(text: AppLocalizations.of(context)!.attendance),
                      Tab(text: AppLocalizations.of(context)!.learningMaterial),
                      Tab(text: AppLocalizations.of(context)!.quizGrades),
                      Tab(text: AppLocalizations.of(context)!.homework),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    GroupDetailsTab(groupModel: groupModel!),
                    AttendanceGroupTab(group: groupModel),
                    GroupMaterialTab(groupId: groupModel!.id),
                    QuizAndGradesTab(group: groupModel),
                    HomeworkTab(groupId: groupModel!.id),
                  ],
                ),
              )));
    } else {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          color: HexColor.fromHex(DemiksColors.accentColor),
        ),
      );
    }
  }
}
