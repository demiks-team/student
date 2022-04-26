import 'package:flutter/material.dart';
import 'package:student/src/shared/services/group_service.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/helpers/date_time/start_end_datetime.dart';
import '../../../../../shared/models/group_model.dart';
import '../../../../../shared/models/quiz_grade_model.dart';
import '../../../../../shared/theme/colors/demiks_colors.dart';
import '../../../../../shared/services/group_service.dart';

class QuizAndGradesTab extends StatefulWidget {
  const QuizAndGradesTab({Key? key, this.group}) : super(key: key);
  final GroupModel? group;

  @override
  State<QuizAndGradesTab> createState() => _QuizAndGradesTabState();
}

class _QuizAndGradesTabState extends State<QuizAndGradesTab>
    with AutomaticKeepAliveClientMixin {
  Future<List<QuizGradeModel>>? quizGradeList;
  final GroupService groupService = GroupService();
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    quizGradeList = getQuizGradeList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Future<List<QuizGradeModel>> getQuizGradeList() async {
    return groupService.getQuizzes(widget.group!.id);
  }

  @override
  bool get wantKeepAlive => true;

  FutureBuilder<List<QuizGradeModel>> _buildBody(BuildContext context) {
    return FutureBuilder<List<QuizGradeModel>>(
      future: quizGradeList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<QuizGradeModel>? quizGradeList = snapshot.data;
          if (quizGradeList!.isNotEmpty) {
            return _buildQuizzes(context, quizGradeList);
          } else {
            return const Center(child: Text('Quiz list is empty'));
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

  ListView _buildQuizzes(
      BuildContext context, List<QuizGradeModel>? quizGrades) {
    return ListView.builder(
      controller: controller,
      itemCount: quizGrades!.length,
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
                                convertDateToLocal(
                                    quizGrades[index].quiz!.startDateTime!),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ]),
                  ])),
              subtitle: Container(
                  margin: const EdgeInsets.only(left: 20, top: 5),
                  child: Column(
                    children: [
                      if (quizGrades[index].quiz!.endDateTime != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(convertStartEndDateHours(
                                    quizGrades[index]
                                        .quiz!
                                        .startDateTime
                                        .toString(),
                                    quizGrades[index]
                                        .quiz!
                                        .endDateTime
                                        .toString())),
                              ),
                            ])
                      else
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text("Offline"),
                              ),
                            ]),
                      if (quizGrades[index].quiz!.durationInMinutes! > 0)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(quizGrades[index]
                                        .quiz!
                                        .durationInMinutes!
                                        .toString() +
                                    " minutes"),
                              ),
                            ]),
                      if (quizGrades[index].grade != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                      quizGrades[index].grade.toString() +
                                          " / " +
                                          quizGrades[index]
                                              .quiz!
                                              .totalPoint
                                              .toString())),
                            ])
                      else
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text("? / " +
                                      quizGrades[index]
                                          .quiz!
                                          .totalPoint
                                          .toString())),
                            ]),
                    ],
                  )),
            ));
      },
    );
  }
}
