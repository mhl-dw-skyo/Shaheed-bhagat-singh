import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../core.dart';

class DashboardCategoriesWidget extends StatelessWidget {
  final DashboardDataModel dashboardDataModel;
  DashboardCategoriesWidget({
    Key key,
    this.dashboardDataModel,
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
              Get.textTheme.headline2.copyWith(
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
                    if (attributes.locationId > 0) {
                      CommonService commonService = Get.find();
                      commonService.sameCategoryBeacons.value = [];
                      commonService.sameCategoryBeacons.refresh();
                      DetailController detailController = Get.find();
                      detailController.getLocationDetailData(attributes.locationId);
                      Get.toNamed('/detail');
                    }
                  },
                );
              }),
        ).pSymmetric(h: 20)
      ],
    );
  }
}
