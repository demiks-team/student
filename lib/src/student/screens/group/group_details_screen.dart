import 'package:flutter/material.dart';
import '../../../shared/helpers/hex_color.dart';
import '../../../shared/helpers/material_color.dart';
import '../../../shared/models/group_model.dart';
import '../../../shared/services/group_service.dart';
import '../../../shared/theme/colors/demiks_colors.dart';
import 'widgets/group_details_tabs/attendance_group_tab.dart';
import 'widgets/group_details_tabs/group_material_tab.dart';
import 'widgets/group_details_tabs/group_details_tab.dart';

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
                    indicatorColor:
                        HexColor.fromHex(DemiksColors.primaryColor),
                    labelColor: Colors.grey,
                    tabs: const <Widget>[
                      Tab(text: "Details"),
                      Tab(text: "Attendance"),
                      Tab(text: "Class Material"),
                      Tab(text: "Quiz & Grades"),
                      Tab(text: "Homework"),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    GroupDetailsTab(groupModel: groupModel!),
                    AttendanceGroupTab(group: groupModel),
                    GroupMaterialTab(groupId: groupModel!.id),
                    Icon(Icons.directions_bike),
                    Icon(Icons.directions_bike),
                  ],
                ),
              )));
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: HexColor.fromHex(DemiksColors.accentColor),
        ),
      );
    }
  }
}
