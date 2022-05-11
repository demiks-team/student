import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/models/question_model.dart';
import 'package:student/src/shared/models/student_answer_model.dart';
import 'package:quiver/async.dart';
import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student/src/student/screens/group/group_details_screen.dart';
import 'package:student/src/student/screens/group/group_list_screen.dart';
import 'package:student/src/student/screens/group/widgets/quiz/quiz_overview.dart';
import 'package:student/src/student/shared-widgets/confirmation.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/models/quiz_arrival_time_model.dart';
import '../../../../../shared/models/quiz_grade_model.dart';
import '../../../../../shared/models/quiz_model.dart';
import '../../../../../shared/services/quiz_service.dart';
import '../../../../../shared/theme/colors/demiks_colors.dart';

class TakeQuiz extends StatefulWidget {
  final QuizModel quiz;
  final int type;
  final String studentGrade;
  TakeQuiz(
      {Key? key,
      required this.quiz,
      required this.type,
      required this.studentGrade})
      : super(key: key);

  @override
  State<TakeQuiz> createState() => _QuizState();
}

class _QuizState extends State<TakeQuiz> with AutomaticKeepAliveClientMixin {
  final QuizService quizService = QuizService();
  final ScrollController controller = ScrollController();

  bool showTimer = true;
  int questionIndex = 0;
  int? selectedAnswerIndex;
  List<QuestionModel>? questionList;
  List<StudentAnswerModel>? studentAnswerList;
  List<StudentAnswerModel>? correctAnswerList;
  int? studentId;
  DateTime? arrivalTime;
  int start = 0;
  int current = 0;
  bool isCounterZero = false;
  bool loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await initializeTheData();
      setState(() {
        loading = false;
        if (widget.type == 1) startTimer();
      });
    });

    super.initState();
  }

  initializeTheData() async {
    await getStudentId();
    await getQuizQuestionList();
    await getStudentAnswerList();
    if (widget.type == 1)
      await getStudentArrivalTime();
    else if (widget.type == 2) await getCorrectAnswerList();
    await updateSelectedAnswerIndex(0);
  }

  getStudentId() async {
    await quizService
        .getStudentId(widget.quiz.group!.schoolId!)
        .then((value) => {
              setState(() => {studentId = value})
            });
  }

  getQuizQuestionList() async {
    await quizService
        .getQuizQuestionList(widget.quiz.id)
        .then((value) => setState(() => {questionList = value}));
  }

  getStudentAnswerList() async {
    await quizService
        .getStudentAnswerList(widget.quiz.id)
        .then((value) => setState(() => {studentAnswerList = value}));
  }

  getStudentArrivalTime() async {
    await quizService.getStudentArrivalTime(widget.quiz.id).then((value) => {
          if (value.isNotEmpty)
            {
              setState(() => arrivalTime = DateTime.parse(value).toLocal()),
              calculateTestDuration()
            }
          else
            {
              updateStudentArrivalTime(),
              setState(() => {start = (widget.quiz.durationInMinutes! * 60)})
            }
        });
  }

  getCorrectAnswerList() async {
    await quizService
        .getCorrectAnswerList(widget.quiz.id)
        .then((value) => setState(() => {correctAnswerList = value}));
  }

  updateStudentArrivalTime() async {
    if (arrivalTime == null && widget.type == 1) {
      QuizArrivalTimeModel quizArrivalTime = QuizArrivalTimeModel(
          quizId: widget.quiz.id,
          studentId: studentId,
          arrivalTime: DateTime.now().toString());
      await quizService.updateStudentArrivalTime(quizArrivalTime);
    }
  }

  calculateTestDuration() {
    var duration = (widget.quiz.durationInMinutes! * 60) -
        ((DateTime.now().millisecondsSinceEpoch -
                arrivalTime!.millisecondsSinceEpoch) ~/
            1000);
    setState(() {
      start = duration > 0 ? duration : 0;
    });
  }

  updateSelectedAnswerIndex(int _questionIndex) async {
    var answer = studentAnswerList!.firstWhereOrNull(
        (a) => a.questionId == questionList![_questionIndex].id);
    setState(() {
      selectedAnswerIndex = answer != null ? answer.answerIndex : null;
    });
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        current = (start - duration.elapsed.inSeconds) > 0
            ? (start - duration.elapsed.inSeconds)
            : 0;
      });
    });

    sub.onDone(() {
      if (isCounterZero == false && widget.type == 1) {
        setState(() {
          isCounterZero = true;
          showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) => submit(dialogContext),
          );
        });
        sub.cancel();
      }
    });
  }

  String intToTimeLeft(int value) {
    int minutes, seconds;
    minutes = value ~/ 60;
    seconds = value - (minutes * 60);

    return "$minutes:$seconds";
  }

  saveAnswer() async {
    if (selectedAnswerIndex != null &&
        selectedAnswerIndex! >= 0 &&
        widget.type == 1) {
      var answer = studentAnswerList!.firstWhereOrNull(
          (a) => a.questionId == questionList![questionIndex].id);
      if (answer != null && answer.answerIndex != selectedAnswerIndex) {
        answer.answerIndex = selectedAnswerIndex;
        await quizService.updateStudentAnswer(answer);
      } else if (answer == null) {
        var studentAnswer = new StudentAnswerModel();
        studentAnswer.answerIndex = selectedAnswerIndex;
        studentAnswer.questionId = questionList![questionIndex].id;
        studentAnswer.question = questionList![questionIndex];
        studentAnswer.studentId = studentId;
        quizService.createStudentAnswer(studentAnswer).then((data) => {
              setState(() {
                studentAnswerList!.add(data);
              })
            });
      }
    }
  }

  bool isAnswerd(QuestionModel question) {
    var answer =
        studentAnswerList!.firstWhereOrNull((a) => a.questionId == question.id);
    if (answer != null && answer.answerIndex != null)
      return true;
    else
      return false;
  }

  bool didGiveCorrectAnswer(QuestionModel question) {
    var studentAnswer =
        studentAnswerList!.firstWhereOrNull((a) => a.questionId == question.id);
    var correctAnswer =
        correctAnswerList!.firstWhere((a) => a.questionId == question.id);
    if (studentAnswer != null &&
        studentAnswer.answerIndex == correctAnswer.answerIndex)
      return true;
    else
      return false;
  }

  goToQuestion(int index) {
    saveAnswer();
    setState(() {
      questionIndex = index;
    });
    updateSelectedAnswerIndex(questionIndex);
  }

  List<IconButton> generateScoreKeeper() {
    List<IconButton> scoreKeeper = [];
    for (var i = 0; i < questionList!.length; i++) {
      if (widget.type == 2) {
        if (didGiveCorrectAnswer(questionList![i]))
          scoreKeeper.add(IconButton(
            icon: Icon(Icons.check_circle, color: Colors.greenAccent),
            onPressed: () {
              goToQuestion(i);
            },
          ));
        else
          scoreKeeper.add(IconButton(
            icon: Icon(Icons.remove_circle, color: Colors.redAccent),
            onPressed: () {
              goToQuestion(i);
            },
          ));
      } else {
        if (isAnswerd(questionList![i]))
          scoreKeeper.add(IconButton(
            icon: Icon(Icons.check_circle_outline, color: Colors.greenAccent),
            onPressed: () {
              goToQuestion(i);
            },
          ));
        else
          scoreKeeper.add(IconButton(
            icon: Icon(Icons.radio_button_unchecked, color: Colors.redAccent),
            onPressed: () {
              goToQuestion(i);
            },
          ));
      }
    }
    return scoreKeeper;
  }

  int getCorrectAnswer() {
    var correctAnswer = correctAnswerList!
        .firstWhere((a) => a.questionId == questionList![questionIndex].id);
    return correctAnswer.answerIndex!;
  }

  AlertDialog submit(BuildContext dialogContext) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(dialogContext)!.submitTitle,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(current == 0
          ? AppLocalizations.of(dialogContext)!.endOfQuizTime
          : AppLocalizations.of(dialogContext)!.submitInstructions),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: HexColor.fromHex(DemiksColors.accentColor)),
          onPressed: () {
            saveAnswer();
            var studentGrade = QuizGradeModel();
            studentGrade.quizId = widget.quiz.id;
            studentGrade.quiz = widget.quiz;
            studentGrade.studentId = studentId;
            quizService.updateStudentGrade(studentGrade).then((data) => {
                  Navigator.of(dialogContext, rootNavigator: true)
                      .push(MaterialPageRoute(
                          builder: (_) => QuizOverview(
                                quizId: widget.quiz.id,
                              )))
                });
          },
          child: Text(AppLocalizations.of(dialogContext)!.submit),
        ),
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: HexColor.fromHex(DemiksColors.primaryColor)),
          onPressed: () {
            if (current == 0)
              Navigator.of(dialogContext, rootNavigator: true)
                  .push(MaterialPageRoute(
                      builder: (_) => GroupDetailsScreen(
                            groupId: widget.quiz.groupId!,
                          )));
            else
              Navigator.of(dialogContext).pop();
          },
          child: Text(AppLocalizations.of(dialogContext)!.cancel),
        ),
      ],
    );
  }

  InkWell generateOption(int index) {
    Color getTheRightColor() {
      if (widget.type == 1) {
        if (selectedAnswerIndex == index) return Color(0xFF6AC259);
      } else {
        if (getCorrectAnswer() == index && selectedAnswerIndex == index)
          return Color(0xFF6AC259);
        else if (getCorrectAnswer() != index && selectedAnswerIndex == index)
          return Color(0xFFE92E30);
        else if (getCorrectAnswer() == index && selectedAnswerIndex != index)
          return Color.fromARGB(255, 136, 135, 135);
      }
      return Color(0xFFC1C1C1);
    }

    IconData getTheRightIcon() {
      return getTheRightColor() == Color(0xFFE92E30) ? Icons.close : Icons.done;
    }

    return InkWell(
      onTap: () {
        if (widget.type == 1)
          setState(() {
            selectedAnswerIndex = index;
          });
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              //  "${index + 1}." +
              questionList![questionIndex].answers![index].answerText!,
              // style: TextStyle(color: Color(0xFFE92E30), fontSize: 16),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: getTheRightColor() == Color(0xFFC1C1C1)
                    ? Colors.transparent
                    : getTheRightColor(),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: getTheRightColor()),
              ),
              child: getTheRightColor() == Color(0xFFC1C1C1)
                  ? null
                  : Icon(getTheRightIcon(), size: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (loading == false) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: HexColor.fromHex(DemiksColors.accentColor)),
            onPressed: () => {
              saveAnswer(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => QuizOverview(
                            quizId: widget.quiz.id,
                          ))),
            },
          ),
          actions: <Widget>[
            if (widget.type == 1)
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.black, textStyle: TextStyle(fontSize: 20)),
                onPressed: () {
                  setState(() {
                    showTimer == true ? showTimer = false : showTimer = true;
                  });
                },
                child: Text(showTimer == true
                    ? (intToTimeLeft(current))
                    : AppLocalizations.of(context)!.showTimer),
              ),
            if (questionIndex == (questionList!.length - 1) && widget.type == 1)
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: TextStyle(fontSize: 20)),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) =>
                          submit(dialogContext),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.submit)),
            if (questionIndex == (questionList!.length - 1) && widget.type == 2)
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => QuizOverview(
                                  quizId: widget.quiz.id,
                                )));
                  },
                  child: Text(AppLocalizations.of(context)!.overview)),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (questionIndex > 0)
                        IconButton(
                          onPressed: () {
                            saveAnswer();
                            setState(() {
                              questionIndex--;
                            });
                            updateSelectedAnswerIndex(questionIndex);
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                      Text.rich(
                        TextSpan(
                          text: AppLocalizations.of(context)!.question +
                              " ${questionIndex + 1}",
                          style: Theme.of(context).textTheme.headline5!,
                          children: [
                            TextSpan(
                              text: "/${questionList!.length}",
                              style: Theme.of(context).textTheme.headline5!,
                            ),
                          ],
                        ),
                      ),
                      if (questionIndex < (questionList!.length - 1))
                        IconButton(
                          onPressed: () {
                            saveAnswer();
                            setState(() {
                              questionIndex++;
                            });
                            updateSelectedAnswerIndex(questionIndex);
                          },
                          icon: Icon(Icons.arrow_forward),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Card(
                  elevation: 4,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            questionList![questionIndex].questionText!,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Color(0xFF101010)),
                          ),
                          SizedBox(height: 10),
                          ...List.generate(
                              questionList![questionIndex].answers!.length,
                              (index) {
                            return generateOption(index);
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: generateScoreKeeper(),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: HexColor.fromHex(DemiksColors.accentColor),
        ),
      );
    }
  }
}
