import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:student/src/shared/services/course_material_service.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/models/course_material_model.dart';
import '../../../../../shared/models/enums.dart';
import '../../../../../shared/no_data.dart';
import '../../../../../shared/services/group_service.dart';
import '../../../../../shared/theme/colors/app_colors.dart';

class CourseMaterialScreen extends StatefulWidget {
  final int courseMaterialId;

  const CourseMaterialScreen({Key? key, required this.courseMaterialId})
      : super(key: key);

  @override
  State<CourseMaterialScreen> createState() => _CourseMaterialScreenState();
}

class _CourseMaterialScreenState extends State<CourseMaterialScreen> {
  CourseMaterialModel? courseMaterial;
  final CourseMaterialService _courseMaterialService = CourseMaterialService();
  final GroupService _groupService = GroupService();
  int currentIndex = 0;
  final ScrollController controller = ScrollController();
  bool completedTasks = false;

  @override
  initState() {
    super.initState();
    getCourseMaterial();
  }

  Future<void> getCourseMaterial() async {
    Future<CourseMaterialModel> futureLearningMaterial =
        _courseMaterialService.getCourseMaterial(widget.courseMaterialId);
    await futureLearningMaterial.then((cm) {
      setState(() {
        courseMaterial = cm;
        completedTasks = true;
      });
    });
  }

  circleSelective() {
    const int pageGroup = 3;
    int firstPage = currentIndex;
    int endPage = currentIndex + pageGroup;
    if (endPage >= courseMaterial!.courseMaterialPages!.length) {
      endPage = courseMaterial!.courseMaterialPages!.length;
    }
    var inkWells = <InkWell>[];
    for (var i = firstPage; i < endPage; i++) {
      inkWells.add(InkWell(
        onTap: () => setState(() => currentIndex = i),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == i
                  ? HexColor.fromHex(AppColors.primaryColor)
                  : Colors.white,
              border: Border.all(
                  color: currentIndex == i
                      ? Colors.white
                      : HexColor.fromHex(AppColors.backgroundColorGray))),
          child: Text((i + 1).toString(),
              style: TextStyle(
                  color: currentIndex == i
                      ? Colors.white
                      : HexColor.fromHex(AppColors.backgroundColorGray),
                  fontSize: MediaQuery.of(context).size.width * 0.06)),
        ),
      ));
    }
    return inkWells;
  }

  getMinuteString(int? estimatedStudyTime) {
    if (estimatedStudyTime == null) {
      return "";
    } else {
      var result = estimatedStudyTime.toString() + " ";
      if (estimatedStudyTime == 1) {
        result += AppLocalizations.of(context)!.minute.toString();
      } else {
        result += AppLocalizations.of(context)!.minutes.toString();
      }
      result += " " + AppLocalizations.of(context)!.toStudy.toString();
      return result;
    }
  }

  buildBody() {
    if (courseMaterial != null &&
        courseMaterial!.courseMaterialPages!.isNotEmpty) {
      return SafeArea(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width * 0.80,
            margin: const EdgeInsets.all(20),
            child: Card(
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.all(
                      20), // IMPORTANT: if this line changes, in some devices may be problem.
                  child: Text(
                    courseMaterial!.courseMaterialPages![currentIndex]
                        .courseMaterialPageContent!.title
                        .toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor.fromHex(AppColors.primaryColor)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    getMinuteString(courseMaterial!
                        .courseMaterialPages![currentIndex]
                        .courseMaterialPageContent!
                        .estimatedStudyTime),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: HexColor.fromHex(AppColors.backgroundColorGray)),
                  ),
                ),
                if (courseMaterial!.courseMaterialPages![currentIndex]
                        .courseMaterialPageContent!.contentType ==
                    CourseMaterialPageContentType.learningMaterial)
                  Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                          controller: controller,
                          child: Html(
                              data: courseMaterial!
                                  .courseMaterialPages![currentIndex]
                                  .courseMaterialPageContent!
                                  .body
                                  .toString()))),
                // if (courseMaterial!.courseMaterialPages![currentIndex]
                //         .courseMaterialPageContent!.contentType ==
                //     CourseMaterialPageContentType.file)
                //   GestureDetector(
                //       onTap: () async {
                //         _groupService.getFileFromGroupLearningMaterial(
                //             courseMaterial!.courseMaterialPages![currentIndex]
                //                 .courseMaterialPageContent!.title
                //                 .toString(),
                //             courseMaterial!.courseMaterialPages![currentIndex]
                //                 .courseMaterialPageContent!.fileNameOnServer
                //                 .toString());
                //       },
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(Icons.download,
                //               color: HexColor.fromHex(AppColors.primaryColor)),
                //           Text(
                //               AppLocalizations.of(context)!.download.toString(),
                //               style: TextStyle(
                //                   color:
                //                       HexColor.fromHex(AppColors.primaryColor),
                //                   fontWeight: FontWeight.bold)),
                //         ],
                //       ))
              ]),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (currentIndex > 0)
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex--;
                  });
                },
                icon: Icon(Icons.arrow_back,
                    color: HexColor.fromHex(AppColors.primaryColor)),
              ),
            ...circleSelective(),
            if (currentIndex <
                (courseMaterial!.courseMaterialPages!.length - 1))
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex++;
                  });
                },
                icon: Icon(Icons.arrow_forward,
                    color: HexColor.fromHex(AppColors.primaryColor)),
              ),
          ]),
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //   Text.rich(
          //     TextSpan(
          //       text: (currentIndex + 1).toString(),
          //       style: Theme.of(context).textTheme.headline5!,
          //       children: [
          //         TextSpan(
          //           text: "/${courseMaterial!.courseMaterialPages!.length}",
          //           style: Theme.of(context).textTheme.headline5!,
          //         ),
          //       ],
          //     ),
          //   ),
          // ])
        ]),
      )));
    } else {
      return const NoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (completedTasks) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(courseMaterial!.title.toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: HexColor.fromHex(AppColors.accentColor)),
              onPressed: () => {Navigator.of(context).pop()},
            ),
          ),
          body: buildBody());
    } else {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          color: HexColor.fromHex(AppColors.accentColor),
        ),
      );
    }
  }
}
