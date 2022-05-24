import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:student/src/shared/services/group_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/models/group_file_model.dart';
import '../../../../../shared/models/group_learning_material_model.dart';
import '../../../../../shared/models/learning_material_model.dart';
import '../../../../../shared/theme/colors/app_colors.dart';
import '../../../../../shared/services/group_service.dart';

class GroupMaterialTab extends StatefulWidget {
  const GroupMaterialTab({Key? key, this.groupId}) : super(key: key);
  final int? groupId;

  @override
  State<GroupMaterialTab> createState() => _GroupMaterialTabState();
}

class _GroupMaterialTabState extends State<GroupMaterialTab>
    with AutomaticKeepAliveClientMixin {
  final GroupService groupService = GroupService();
  List<GroupLearningMaterialModel>? groupLearningMaterials;
  List<GroupFileModel>? groupFileList;
  bool completedTasks = false;

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await initializeTheData();
      completedTasks = true;
    });
    super.initState();
  }

  Future<void> initializeTheData() async {
    await getGroupLearningMaterialList();
    await getGroupLearningMaterialFiles();
    await convertGroupFilesToGroupLearning();
  }

  Future<void> getGroupLearningMaterialList() async {
    await groupService
        .getGroupLearningMaterial(widget.groupId!)
        .then((gl) => groupLearningMaterials = gl);
  }

  Future<void> getGroupLearningMaterialFiles() async {
    await groupService
        .getGroupLearningMaterialFiles(widget.groupId!)
        .then((gl) => setState(() {
              groupFileList = gl;
            }));
  }

  convertGroupFilesToGroupLearning() async {
    if (groupFileList != null) {
      for (var gf in groupFileList!) {
        var groupLearning =
            GroupLearningMaterialModel(groupId: 0, learningMaterialId: 0);
        groupLearning.learningMaterial = LearningMaterialModel(id: 0);
        groupLearning.learningMaterial?.id = 0;
        groupLearning.learningMaterial?.title = gf.fileName;
        groupLearning.learningMaterial?.description = gf.description;
        groupLearning.learningMaterial?.estimatedStudyTime =
            gf.estimatedStudyTime;
        groupLearning.learningMaterial?.guid = gf.fileGuid;
        groupLearningMaterials!.add(groupLearning);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: completedTasks
            ? groupLearningMaterials != null &&
                    groupLearningMaterials!.isNotEmpty
                ? ListView(
                    padding: const EdgeInsets.only(
                        top: 25, left: 35, right: 35, bottom: 25),
                    children: [
                      for (var groupLearningMaterials
                          in groupLearningMaterials!)
                        Card(
                            elevation: 4,
                            child: ListTile(
                              title: Container(
                                margin: const EdgeInsets.only(
                                    left: 15, top: 25, bottom: 15, right: 15),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          groupLearningMaterials
                                              .learningMaterial!.title
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      )
                                    ]),
                              ),
                              subtitle: Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15),
                                  child: Column(
                                    children: [
                                      if (groupLearningMaterials
                                              .learningMaterial!
                                              .description
                                              ?.isNotEmpty ==
                                          true)
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Text(
                                                    groupLearningMaterials
                                                        .learningMaterial!
                                                        .description
                                                        .toString()),
                                              ),
                                            ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                          .estimatedStudyTime +
                                                      ": " +
                                                      groupLearningMaterials
                                                          .learningMaterial!
                                                          .estimatedStudyTime
                                                          .toString()),
                                            ),
                                          ]),
                                      if (groupLearningMaterials
                                              .learningMaterial!
                                              .body
                                              ?.isNotEmpty ==
                                          true)
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        const BoxConstraints(),
                                                    icon: Icon(
                                                        Icons.library_books,
                                                        color: HexColor.fromHex(
                                                            AppColors
                                                                .primaryColor)),
                                                    onPressed: () {
                                                      showModalBottomSheet<
                                                              void>(
                                                          context: context,
                                                          isScrollControlled:
                                                              true,
                                                          builder: (context) =>
                                                              Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.75,
                                                                  child: Center(
                                                                      child:
                                                                          Column(
                                                                    children: [
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .center,
                                                                          child:
                                                                              IconButton(
                                                                            icon:
                                                                                Icon(Icons.minimize, color: HexColor.fromHex(AppColors.accentColor)),
                                                                            onPressed: () =>
                                                                                Navigator.of(context).pop(),
                                                                          )),
                                                                      Expanded(
                                                                          child:
                                                                              ListView(
                                                                        children: [
                                                                          ListTile(
                                                                            title: SingleChildScrollView(
                                                                                padding: const EdgeInsets.all(5),
                                                                                child: Html(
                                                                                  data: groupLearningMaterials.learningMaterial!.body.toString(),
                                                                                )),
                                                                          )
                                                                        ],
                                                                      ))
                                                                    ],
                                                                  ))));
                                                    },
                                                  )),
                                            ]),
                                      if (groupLearningMaterials
                                              .learningMaterial!
                                              .guid
                                              ?.isNotEmpty ==
                                          true)
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(),
                                                  icon: Icon(
                                                      Icons.download,
                                                      color: HexColor
                                                          .fromHex(AppColors
                                                              .primaryColor)),
                                                  onPressed: () async => groupService
                                                      .getFileFromGroupLearningMaterial(
                                                          groupLearningMaterials
                                                              .learningMaterial!
                                                              .title!,
                                                          groupLearningMaterials
                                                              .learningMaterial!
                                                              .guid!)),
                                            ])
                                    ],
                                  )),
                            ))
                    ],
                  )
                : Center(
                    child:
                        Text(AppLocalizations.of(context)!.noLearningMaterial))
            : Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: HexColor.fromHex(AppColors.accentColor),
                ),
              ));
  }
}
