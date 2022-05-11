import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student/src/shared/models/group_student_model.dart';
import 'package:student/src/shared/models/question_model.dart';
import 'package:student/src/shared/models/quiz_model.dart';
import 'package:student/src/shared/models/student_answer_model.dart';

import '../../authentication/helpers/dio/dio_api.dart';
import '../models/quiz_arrival_time_model.dart';
import '../models/quiz_grade_model.dart';

class QuizService {
  Future<QuizModel> getQuiz(int id) async {
    var response = await DioApi()
        .dio
        .get(dotenv.env['api'].toString() + "quizzes/quiz/" + id.toString());

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));
    return QuizModel.fromJson(decodedList);
  }

  Future<int> getQuizQuestionsCount(int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "quizzes/" +
        id.toString() +
        '/questionscount');

    return response.data;
  }

  Future<List<QuestionModel>> getQuizQuestionList(int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        'quizzes/' +
        id.toString() +
        '/questionList');

    List decodedList = jsonDecode(json.encode(response.data));

    List<QuestionModel> questions = decodedList
        .map(
          (dynamic item) => QuestionModel.fromJson(item),
        )
        .toList();
    return questions;
  }

  Future<List<StudentAnswerModel>> getCorrectAnswerList(int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        'quizzes/' +
        id.toString() +
        '/correctAnswers');

    List decodedList = jsonDecode(json.encode(response.data));

    List<StudentAnswerModel> answers = decodedList
        .map(
          (dynamic item) => StudentAnswerModel.fromJson(item),
        )
        .toList();

    return answers;
  }

  Future<List<StudentAnswerModel>> getStudentAnswerList(int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        'quizzes/quiz/' +
        id.toString() +
        '/answers');

    List decodedList = jsonDecode(json.encode(response.data));

    List<StudentAnswerModel> answers = decodedList
        .map(
          (dynamic item) => StudentAnswerModel.fromJson(item),
        )
        .toList();

    return answers;
  }

  Future<String> getStudentGrade(int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        'quizzes/quiz/' +
        id.toString() +
        '/studentGrade');
    return response.data.toString();
  }

  Future<int> getStudentId(int schoolId) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        'quizzes/schoolId/' +
        schoolId.toString() +
        '/studentId');

    return response.data;
  }

  Future<String> getStudentArrivalTime(int id) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        'quizzes/quiz/' +
        id.toString() +
        '/studentArrivalTime');

    return response.data;
  }

  Future<void> updateStudentArrivalTime(
      QuizArrivalTimeModel quizArrivalTime) async {
    await DioApi().dio.put(
        dotenv.env['api'].toString() + 'quizzes/studentArrivalTime',
        data: quizArrivalTime.toJson());
  }

  Future<void> updateStudentAnswer(StudentAnswerModel studentAnswer) async {
    await DioApi().dio.put(
        dotenv.env['api'].toString() + 'quizzes/studentAnswer',
        data: studentAnswer.toJson());
  }

  Future<void> updateStudentGrade(QuizGradeModel quizGradeModel) async {
    await DioApi().dio.put(
        dotenv.env['api'].toString() + 'quizzes/studentGrade',
        data: quizGradeModel.toJson());
  }

  Future<StudentAnswerModel> createStudentAnswer(
      StudentAnswerModel studentAnswer) async {
    var response = await DioApi().dio.post(
        dotenv.env['api'].toString() + 'quizzes/studentAnswer',
        data: studentAnswer.toJson());

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));
    return StudentAnswerModel.fromJson(decodedList);
  }
}
