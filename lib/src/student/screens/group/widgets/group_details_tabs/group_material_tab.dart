import 'package:flutter/material.dart';
import 'package:student/src/shared/services/group_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student/src/student/screens/group/widgets/course_material/course_material.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/models/course_material_model.dart';
import '../../../../../shared/models/group_model.dart';
import '../../../../../shared/theme/colors/app_colors.dart';
import '../../../../../shared/services/group_service.dart';

class GroupMaterialTab extends StatefulWidget {
  const GroupMaterialTab({Key? key, this.group}) : super(key: key);
  final GroupModel? group;

  @override
  State<GroupMaterialTab> createState() => _GroupMaterialTabState();
}

class _GroupMaterialTabState extends State<GroupMaterialTab>
    with AutomaticKeepAliveClientMixin {
  Future<List<CourseMaterialModel>>? courseMaterials;
  final GroupService groupService = GroupService();
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    courseMaterials = getCourseMaterial();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Future<List<CourseMaterialModel>> getCourseMaterial() async {
    return groupService.getGroupCourseMaterials(
        widget.group!.id, widget.group!.numberOfCompletedSessions!);
  }

  @override
  bool get wantKeepAlive => true;

  FutureBuilder<List<CourseMaterialModel>> _buildBody(BuildContext context) {
    return FutureBuilder<List<CourseMaterialModel>>(
      future: courseMaterials,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<CourseMaterialModel>? courseMaterial = snapshot.data;
          if (courseMaterial!.isNotEmpty) {
            return _buildSessionSummary(context, courseMaterial);
          } else {
            return Center(
                child: Text(AppLocalizations.of(context)!.noCourseInTheClass));
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

  ListView _buildSessionSummary(
      BuildContext context, List<CourseMaterialModel>? courseMaterialModel) {
    return ListView.builder(
      controller: controller,
      itemCount: courseMaterialModel!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CourseMaterialScreen(
                            courseMaterialId: courseMaterialModel[index].id)));
              },
              title: Container(
                  margin: const EdgeInsets.only(
                      left: 15, top: 25, bottom: 15, right: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        courseMaterialModel[index]
                                            .title
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ]),
                      ])),
            ));
      },
    );
  }
}
