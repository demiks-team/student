import 'package:flutter/material.dart';
import '../../../shared/helpers/hex_color.dart';
import '../../../shared/models/class_model.dart';
import '../../../shared/services/class_service.dart';
import '../../../shared/theme/colors/demiks_colors.dart';

class ClassDetails extends StatefulWidget {
  final int classId;

  const ClassDetails({Key? key, required this.classId}) : super(key: key);

  @override
  State<ClassDetails> createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State<ClassDetails> {
  ClassModel? classModel;
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
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(classModel!.title.toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: HexColor.fromHex(DemiksColors.accentColor)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(
                color: HexColor.fromHex(DemiksColors.accentColor)),
          ),
          body: Container(
              padding: const EdgeInsets.only(top: 35),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(classModel!.school!.name.toString()),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(classModel!.teacher!.fullName.toString()),
                  ),
                ]),
                if (classModel!.course != null)
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(classModel!.course!.name.toString()),
                    ),
                  ]),
                if (classModel!.room != null)
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(classModel!.room!.title.toString()),
                    ),
                  ]),
              ])));
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: HexColor.fromHex(DemiksColors.accentColor),
        ),
      );
    }
  }

  void loadClass() async {
    Future<ClassModel> futureClass = classService.getClass(widget.classId);
    await futureClass.then((cm) {
      setState(() {
        classModel = cm;
      });
    });
  }
}
