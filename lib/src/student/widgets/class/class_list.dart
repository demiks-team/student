import 'package:flutter/material.dart';
import 'package:student/src/shared/services/class_service.dart';
import 'package:student/src/student/screens/class/class_details_screen.dart';

import '../../../shared/models/class_model.dart';

class ClassList extends StatelessWidget {
  const ClassList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  FutureBuilder<List<Class>> _buildBody(BuildContext context) {
    final ClassService classService = ClassService();
    return FutureBuilder<List<Class>>(
      future: classService.getClasses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Class>? classes = snapshot.data;
          return _buildClasses(context, classes);
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber[600],
            ),
          );
        }
      },
    );
  }

  ListView _buildClasses(BuildContext context, List<Class>? classes) {
    return ListView.builder(
      itemCount: classes!.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ClassDetails(classId: classes[index].id)));
            },
            title: Text(
              classes[index].title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(classes[index].body.toString()),
          ),
        );
      },
    );
  }
}
