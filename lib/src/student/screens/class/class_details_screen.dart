import 'package:flutter/material.dart';
import '../../../shared/models/class_model.dart';
import '../../../shared/services/class_service.dart';

class ClassDetails extends StatefulWidget {
  final int classId;

  const ClassDetails({Key? key, required this.classId}) : super(key: key);

  @override
  State<ClassDetails> createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State<ClassDetails> {
  Class? classModel;
  final ClassService classService = ClassService();

  @override
  initState() {
    super.initState();
    loadClass();
  }

  @override
  Widget build(BuildContext context) {
    if (classModel != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(classModel!.title.toString()),
          ),
          body: Container(
            child: Text(classModel!.title.toString()),
          ));
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.amber[600],
        ),
      );
    }
  }

  void loadClass() async {
    Future<Class> futureClass = classService.getClass(widget.classId);
    await futureClass.then((cm) {
      setState(() {
        classModel = cm;
      });
    });
  }
}
