import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:student/src/shared/models/quiz_model.dart';
import 'package:student/src/shared/services/quiz_service.dart';
import 'package:student/src/student/screens/group/group_details_screen.dart';
import 'package:student/src/student/screens/group/group_list_screen.dart';
import 'package:student/src/student/screens/group/widgets/quiz/take_quiz.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/theme/colors/app_colors.dart';

class QuizOverview extends StatefulWidget {
  final int quizId;

  QuizOverview({Key? key, required this.quizId}) : super(key: key);

  @override
  State<QuizOverview> createState() => _QuizOverviewState();
}

class _QuizOverviewState extends State<QuizOverview>
    with AutomaticKeepAliveClientMixin {
  final QuizService quizService = QuizService();
  final ScrollController controller = ScrollController();
  int? type;
  QuizModel? quiz;
  int? questionsCount;
  String? studentGrade;
  bool loading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await initializeTheData();
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  initializeTheData() async {
    await getQuiz();
    await getQuizQuestionsCount();
    await getStudentGrade();
    await claculateType();
  }

  getQuiz() async {
    await quizService.getQuiz(widget.quizId).then((value) => {
          setState(() => {quiz = value})
        });
  }

  getQuizQuestionsCount() async {
    await quizService.getQuizQuestionsCount(widget.quizId).then((value) => {
          setState(() => {questionsCount = value})
        });
  }

  getStudentGrade() async {
    await quizService.getStudentGrade(widget.quizId).then((value) => {
          setState(() => {studentGrade = value})
        });
  }

  claculateType() async {
    if (quiz!.displayCorrectAnswer == false &&
        studentGrade!.isNotEmpty == true) {
      setState(() => {type = 3});
    } else if (studentGrade!.isNotEmpty == false &&
        DateTime.now().isBefore(DateTime.parse(quiz!.endDateTime!).toLocal()) &&
        DateTime.now()
            .isAfter(DateTime.parse(quiz!.startDateTime!).toLocal())) {
      setState(() => {type = 1});
    } else if (quiz!.displayCorrectAnswer &&
        (studentGrade!.isNotEmpty == true ||
            DateTime.now()
                .isAfter(DateTime.parse(quiz!.endDateTime!).toLocal()))) {
      setState(() => {type = 2});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (quiz != null && loading == false) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: HexColor.fromHex(AppColors.accentColor)),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        GroupDetailsScreen(groupId: quiz!.groupId!))),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                    (type == 1
                        ? AppLocalizations.of(context)!.welcome
                        : (type == 2
                            ? AppLocalizations.of(context)!.review
                            : AppLocalizations.of(context)!.done)),
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Color(0xFF101010))),
                Text(
                    (type == 1
                            ? (AppLocalizations.of(context)!.to + " ")
                            : "") +
                        (quiz!.title != null
                            ? quiz!.title!
                            : AppLocalizations.of(context)!.quiz),
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Color(0xFF101010))),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(AppLocalizations.of(context)!.quizRule,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(questionsCount.toString(),
                              style: Theme.of(context).textTheme.headline5),
                          Text(AppLocalizations.of(context)!.questions,
                              style: Theme.of(context).textTheme.headline5)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(quiz!.durationInMinutes.toString(),
                              style: Theme.of(context).textTheme.headline5),
                          Text(AppLocalizations.of(context)!.minutes,
                              style: Theme.of(context).textTheme.headline5)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                              (type == 2
                                  ? (studentGrade!.isNotEmpty == true
                                      ? (studentGrade! +
                                          "/" +
                                          quiz!.totalPoint.toString())
                                      : ("?/" + quiz!.totalPoint.toString()))
                                  : quiz!.totalPoint.toString()),
                              style: TextStyle(
                                  color: HexColor.fromHex(
                                      AppColors.primaryColor),
                                  fontSize: 24)),
                          Text(AppLocalizations.of(context)!.points,
                              style: Theme.of(context).textTheme.headline5)
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                      (type == 1
                          ? (AppLocalizations.of(context)!.areYouReady)
                          : (type == 2
                              ? (AppLocalizations.of(context)!.reviewAnswers)
                              : (AppLocalizations.of(context)!
                                  .submittedSuccessfully))),
                      style: Theme.of(context).textTheme.headline6),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: HexColor.fromHex("6c757d")),
                  onPressed: () {
                    if (type == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  GroupDetailsScreen(groupId: quiz!.groupId!)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TakeQuiz(
                                    quiz: quiz!,
                                    type: type!,
                                    studentGrade: studentGrade!,
                                  )));
                    }
                  },
                  child: Text(type == 1
                      ? (AppLocalizations.of(context)!.start)
                      : (type == 2
                          ? (AppLocalizations.of(context)!.review)
                          : (AppLocalizations.of(context)!.close))),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: HexColor.fromHex(AppColors.accentColor),
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
