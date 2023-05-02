import 'package:flutter/material.dart';
import 'package:student/src/shared/no_data.dart';
import 'package:student/src/shared/services/group_service.dart';
import 'package:student/src/student/screens/group/group_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/helpers/colors/hex_color.dart';
import '../../../shared/models/group_model.dart';
import '../../../shared/theme/colors/app_colors.dart';

class GroupListScreen extends StatefulWidget {
  const GroupListScreen({Key? key}) : super(key: key);

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.classes),
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          color: HexColor.fromHex(AppColors.accentColor),
          backgroundColor: Theme.of(context).primaryColor,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            setState(() {});
          },
          child: _buildBody(context),
        ));
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
              return RefreshIndicator(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(AppLocalizations.of(context)!.noClass),
                    ),
                    ListView()
                  ],
                ),
                onRefresh: () async {
                  setState(() {});
                },
              );
            }
          } else {
            return RefreshIndicator(
              child: Stack(
                children: <Widget>[const NoData(), ListView()],
              ),
              onRefresh: () async {
                setState(() {});
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: HexColor.fromHex(AppColors.accentColor),
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
                  margin: const EdgeInsets.only(
                      left: 15, top: 25, bottom: 15, right: 15),
                  child: Text(
                    groups[index].title.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              subtitle: Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (groups[index].teacher != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child:
                              Text(groups[index].teacher!.fullName.toString()),
                        ),
                      if (groups[index].course != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(groups[index].course!.name.toString()),
                        ),
                      if (groups[index].room != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(groups[index].room!.title.toString()),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Icon(Icons.link, size: 30),
                        ],
                      ),
                    ],
                  )),
            ));
      },
    );
  }
}
