import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../core.dart';

class DashboardCategoriesWidget extends StatelessWidget {
  final DashboardDataModel dashboardDataModel;
  DashboardCategoriesWidget({
    Key? key,
    required this.dashboardDataModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dashboardDataModel.moduleName.text
            .textStyle(
              Get.textTheme.headline2!.copyWith(
                color: Get.theme.indicatorColor.withOpacity(0.5),
              ),
            )
            .make()
            .pSymmetric(h: 20),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: Get.width,
          height: 190,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: dashboardDataModel.attributes.length,
              itemBuilder: (context, index) {
                Attributes attributes = dashboardDataModel.attributes.elementAt(index);
                return BirdViewWidget(
                  showVideoIcon: false,
                  showTitle: true,
                  width: 150,
                  height: 150,
                  attributes: attributes,
                  onTap: () async {
                    CategoryTypeController categoryTypeController = Get.find();
                    CommonService commonService = Get.find();
                    commonService.selectedCategoryName.value = attributes.title;
                    commonService.selectedCategoryName.refresh();
                    int catDataIndex = commonService.offlineCategoriesData.value.data.indexWhere((element) => element.id == attributes.id);
                    if (catDataIndex > -1) {
                      commonService.trailData.value = commonService.offlineCategoriesData.value.data.elementAt(catDataIndex).attributes;
                      commonService.trailData.refresh();
                      categoryTypeController.initService();
                    } else {
                      Fluttertoast.showToast(
                        msg: "Sorry no data available for this category.",
                        backgroundColor: Colors.red,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 5,
                      );
                    }
                    Get.toNamed('/category_types');
                  },
                );
              }),
        ).pSymmetric(h: 20)
      ],
    );
  }
}
