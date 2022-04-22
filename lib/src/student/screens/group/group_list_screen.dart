import 'package:flutter/material.dart';
import 'package:student/src/shared/services/group_service.dart';
import 'package:student/src/student/screens/group/group_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/helpers/hex_color.dart';
import '../../../shared/models/group_model.dart';
import '../../../shared/theme/colors/demiks_colors.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(context),
    );
  }

  FutureBuilder<List<GroupModel>> _buildBody(BuildContext context) {
    final GroupService groupService = GroupService();
    return FutureBuilder<List<GroupModel>>(
      future: groupService.getGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<GroupModel>? classes = snapshot.data;
          if (classes != null) {
            if (classes.isNotEmpty) {
              return _buildClasses(context, classes);
            } else {
              return const Center(child: Text('Class list is empty'));
            }
          } else {
            return Text(AppLocalizations.of(context)!.noClass);
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

  ListView _buildClasses(BuildContext context, List<GroupModel>? groups) {
    return ListView.builder(
      itemCount: groups!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            GroupDetailsScreen(groupId: groups[index].id)));
              },
              title: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    groups[index].title.toString(),
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
                                  Text(groups[index].school!.name.toString()),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                  groups[index].teacher!.fullName.toString()),
                            ),
                          ]),
                      if (groups[index].course != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child:
                                    Text(groups[index].course!.name.toString()),
                              ),
                            ]),
                      if (groups[index].room != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child:
                                    Text(groups[index].room!.title.toString()),
                              ),
                            ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Icon(Icons.link, size: 30),
                          // IconButton(
                          //   iconSize: 30,
                          //   icon: const Icon(Icons.link),
                          // onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => ClassDetails(
                          //             groupId: classes[index].id)));
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  )),
            ));
      },
    );
  }
}
