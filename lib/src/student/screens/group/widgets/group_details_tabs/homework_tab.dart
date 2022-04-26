import 'package:flutter/material.dart';
import 'package:student/src/shared/services/group_service.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/helpers/date_time/start_end_datetime.dart';
import '../../../../../shared/models/homework_model.dart';
import '../../../../../shared/theme/colors/demiks_colors.dart';
import '../../../../../shared/services/group_service.dart';

class HomeworkTab extends StatefulWidget {
  const HomeworkTab({Key? key, this.groupId}) : super(key: key);
  final int? groupId;

  @override
  State<HomeworkTab> createState() => _HomeworkTabState();
}

class _HomeworkTabState extends State<HomeworkTab>
    with AutomaticKeepAliveClientMixin {
  Future<List<HomeworkModel>>? homeworks;
  final GroupService groupService = GroupService();
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    homeworks = getHomeworks();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Future<List<HomeworkModel>> getHomeworks() async {
    return groupService.getHomeworks(widget.groupId!);
  }

  @override
  bool get wantKeepAlive => true;

  FutureBuilder<List<HomeworkModel>> _buildBody(BuildContext context) {
    return FutureBuilder<List<HomeworkModel>>(
      future: homeworks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<HomeworkModel>? homeworkList = snapshot.data;
          if (homeworkList!.isNotEmpty) {
            return _buildHomeworks(context, homeworkList);
          } else {
            return const Center(child: Text('Homework list is empty'));
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

  ListView _buildHomeworks(
      BuildContext context, List<HomeworkModel>? homeworks) {
    return ListView.builder(
      controller: controller,
      itemCount: homeworks!.length,
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
                                convertDateToLocal(homeworks[index].createdOn!),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ]),
                  ])),
              subtitle: Container(
                  margin: const EdgeInsets.only(left: 20, top: 5),
                  child: Column(
                    children: [
                      if (homeworks[index].deadline != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text("Deadline : " +
                                    convertDateToLocal(
                                        homeworks[index].deadline!)),
                              ),
                            ]),
                      if (homeworks[index].description != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                    homeworks[index].description!.toString()),
                              ),
                            ]),
                      if (homeworks[index].grade != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(homeworks[index].grade!.toString()),
                              ),
                            ]),
                    ],
                  )),
            ));
      },
    );
  }
}
