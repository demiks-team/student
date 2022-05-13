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
  Future<List<GroupLearningMaterialModel>>? groupLearningMaterial;
  final GroupService groupService = GroupService();
  List<GroupFileModel>? groupFileList;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await getGroupLearningMaterialList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: _buildBody(context));
  }

  Future<List<GroupLearningMaterialModel>>
      getGroupLearningMaterialList() async {
    groupLearningMaterial =
        groupService.getGroupLearningMaterial(widget.groupId!);

    await getGroupLearningMaterialFiles();

    return groupLearningMaterial!;
  }

  Future<List<GroupFileModel>> getGroupLearningMaterialFiles() async {
    var groupMaterialFile =
        groupService.getGroupLearningMaterialFiles(widget.groupId!);

    await convertGroupFilesToGroupLearning(groupMaterialFile);

    return groupMaterialFile;
  }

  convertGroupFilesToGroupLearning(
      Future<List<GroupFileModel>> groupMaterialFile) async {
    await groupMaterialFile.then((value) => setState(() {
          groupFileList = value;
        }));

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
        groupLearningMaterial?.then((value) => value.add(groupLearning));
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  FutureBuilder<List<GroupLearningMaterialModel>> _buildBody(
      BuildContext context) {
    return FutureBuilder<List<GroupLearningMaterialModel>>(
      future: groupLearningMaterial,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<GroupLearningMaterialModel>? classLearningMaterials =
              snapshot.data;
          if (classLearningMaterials != null) {
            if (classLearningMaterials.isNotEmpty) {
              return _buildClassLearningMaterials(
                  context, classLearningMaterials);
            } else {
              return Center(
                  child:
                      Text(AppLocalizations.of(context)!.noLearningMaterial));
            }
          } else {
            return Center(
                child: Text(AppLocalizations.of(context)!.noLearningMaterial));
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

  ListView _buildClassLearningMaterials(BuildContext context,
      List<GroupLearningMaterialModel>? groupLearningMaterials) {
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        groupLearningMaterials[index]
                            .learningMaterial!
                            .title
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ]),
              ),
              subtitle: Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Column(
                    children: [
                      if (groupLearningMaterials[index]
                              .learningMaterial!
                              .description
                              ?.isNotEmpty ==
                          true)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(groupLearningMaterials[index]
                                    .learningMaterial!
                                    .description
                                    .toString()),
                              ),
                            ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(AppLocalizations.of(context)!
                                      .estimatedStudyTime +
                                  ": " +
                                  groupLearningMaterials[index]
                                      .learningMaterial!
                                      .estimatedStudyTime
                                      .toString()),
                            ),
                          ]),
                      if (groupLearningMaterials[index]
                              .learningMaterial!
                              .body
                              ?.isNotEmpty ==
                          true)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: Icon(Icons.library_books,
                                        color: HexColor.fromHex(
                                            AppColors.primaryColor)),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) => Container(
                                              padding: const EdgeInsets.all(2),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.75,
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons.minimize,
                                                            color: HexColor.fromHex(
                                                                AppColors
                                                                    .accentColor)),
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                      )),
                                                  Expanded(
                                                      child: ListView(
                                                    children: [
                                                      ListTile(
                                                        title:
                                                            SingleChildScrollView(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: Html(
                                                                  data: groupLearningMaterials[
                                                                          index]
                                                                      .learningMaterial!
                                                                      .body
                                                                      .toString(),
                                                                )),
                                                      )
                                                    ],
                                                  ))
                                                ],
                                              ))));
                                    },
                                  )),
                            ]),
                      if (groupLearningMaterials[index]
                              .learningMaterial!
                              .guid
                              ?.isNotEmpty ==
                          true)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(Icons.download,
                                      color: HexColor.fromHex(
                                          AppColors.primaryColor)),
                                  onPressed: () async => groupService
                                      .getFileFromGroupLearningMaterial(
                                          groupLearningMaterials[index]
                                              .learningMaterial!
                                              .title!,
                                          groupLearningMaterials[index]
                                              .learningMaterial!
                                              .guid!)),
                            ])
                    ],
                  )),
            ));
      },
    );
  }
}
