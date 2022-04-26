import 'package:flutter/material.dart';
import 'package:student/src/shared/services/group_service.dart';

import '../../../../../shared/helpers/hex_color.dart';
import '../../../../../shared/models/group_file_model.dart';
import '../../../../../shared/models/group_learning_material_model.dart';
import '../../../../../shared/models/learning_material_model.dart';
import '../../../../../shared/theme/colors/demiks_colors.dart';
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

  @override
  void initState() {
    super.initState();

    var futures = <Future>[];
    futures.add(getGroupLearningMaterialFiles());
    futures.add(getGroupLearningMaterialList());
    Future.wait(futures);

    convertGroupFilesToGroupLearning();

    // Future.wait([
    //   getGroupLearningMaterialFiles(),
    //   getGroupLearningMaterialList(),
    //   convertGroupFilesToGroupLearning()
    // ]);
    //.then((List<dynamic> responses) => responses[2]);

    print("after future");
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
    return groupLearningMaterial!;
  }

  Future<List<GroupFileModel>> getGroupLearningMaterialFiles() async {
    var myAAA =
        await groupService.getGroupLearningMaterialFiles(widget.groupId!);
    groupFileList = myAAA;
    return myAAA;
  }

  // Future<List<GroupLearningMaterialModel>>
  convertGroupFilesToGroupLearning() {
    print(groupLearningMaterial.toString());
    print(groupFileList.toString());
    // if (groupFileList != null) {
    //   print("if executed");
    //   for (var gf in groupFileList!) {
    //     print(gf.fileName);
    //     var groupLearning =
    //         GroupLearningMaterialModel(groupId: 0, learningMaterialId: 0);
    //     groupLearning.learningMaterial = LearningMaterialModel(id: 0);
    //     groupLearning.learningMaterial!.id = 0;
    //     groupLearning.learningMaterial!.title = gf.fileName;
    //     // groupLearning.learningMaterial!.description = gf.description;
    //     // groupLearning.learningMaterial!.estimatedStudyTime = 25;
    //     groupLearningMaterial!.then((value) => value.add(groupLearning));
    //   }
    // }

    // groupLearningMaterial!.then((value) {
    //   for (var item in value) {
    //     print(item.groupId);
    //   }
    // });
    print("Grouppppp");
    // return groupLearningMaterial!;
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
          if (classLearningMaterials!.isNotEmpty) {
            return _buildClassLearningMaterials(
                context, classLearningMaterials);
          } else {
            return const Center(child: Text('Class material is empty'));
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

  ListView _buildClassLearningMaterials(BuildContext context,
      List<GroupLearningMaterialModel>? groupLearningMaterials) {
    return ListView.builder(
      itemCount: groupLearningMaterials!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              title: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    groupLearningMaterials[index]
                        .learningMaterial!
                        .title
                        .toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              subtitle: Container(
                  margin: const EdgeInsets.only(left: 8, top: 5),
                  child: Column(
                    children: [
                      if (groupLearningMaterials[index]
                              .learningMaterial!
                              .description !=
                          null)
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
                              child: Text("Estimated Study Time : " +
                                  groupLearningMaterials[index]
                                      .learningMaterial!
                                      .estimatedStudyTime
                                      .toString() +
                                  " (in minutes)"),
                            ),
                          ]),
                    ],
                  )),
            ));
      },
    );
  }
}
