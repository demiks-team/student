import 'package:flutter/material.dart';
import 'package:student/src/shared/services/class_service.dart';
import 'package:student/src/student/screens/class/class_details_screen.dart';

import '../../../shared/helpers/hex_color.dart';
import '../../../shared/models/class_model.dart';
import '../../../shared/theme/colors/demiks_colors.dart';

class ClassList extends StatelessWidget {
  const ClassList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  FutureBuilder<List<ClassModel>> _buildBody(BuildContext context) {
    final ClassService classService = ClassService();
    return FutureBuilder<List<ClassModel>>(
      future: classService.getClasses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<ClassModel>? classes = snapshot.data;
          if (classes != null) {
            return _buildClasses(context, classes);
          } else {
            return const Text('This class list is empty');
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

  ListView _buildClasses(BuildContext context, List<ClassModel>? classes) {
    return ListView.builder(
      itemCount: classes!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35),
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
              title: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    classes[index].title.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              subtitle: Container(
                  margin: const EdgeInsets.only(left: 8, top: 5),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child:
                                  Text(classes[index].school!.name.toString()),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                  classes[index].teacher!.fullName.toString()),
                            ),
                          ]),
                      if (classes[index].course != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                    classes[index].course!.name.toString()),
                              ),
                            ]),
                      if (classes[index].room != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child:
                                    Text(classes[index].room!.title.toString()),
                              ),
                            ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 30,
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => ClassDetails(
                              //             classId: classes[index].id)));
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
            ));
      },
    );
  }
}
