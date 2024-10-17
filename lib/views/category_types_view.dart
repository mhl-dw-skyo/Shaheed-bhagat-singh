import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:punjab_tourism/utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../core.dart';

class CategoryTypesView extends GetView<CategoryTypeController> {
  CategoryTypesView({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldDashboardKey =
      GlobalKey<ScaffoldState>(debugLabel: '_scaffoldDashboardKey');
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    return Container(
      color: Get.theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          key: scaffoldDashboardKey,
          backgroundColor: Get.theme.primaryColor,
          appBar: AppBar(
            bottomOpacity: 0,
            shadowColor: Colors.transparent,
            foregroundColor: Get.theme.indicatorColor,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Get.theme.indicatorColor,
                  size: 25,
                )),
            centerTitle: false,
            actions: [
              InkWell(
                onTap: () {
                  scaffoldDashboardKey.currentState?.openEndDrawer();
                },
                child: SvgPicture.asset(
                  "assets/images/menu.svg",
                  color: Get.theme.indicatorColor,
                ),
              ).pOnly(right: 20)
            ],
          ),
          endDrawer: DrawerWidget(),
          body: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                commonService.selectedCategoryName.value.text
                    .textStyle(
                      headline1().copyWith(
                        color: Get.theme.indicatorColor,
                        fontSize: 30,
                      ),
                    )
                    .make()
                    .pOnly(bottom: 20, left: 22),
                commonService.trailData.isNotEmpty
                    ? Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -2.5),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Get.theme.indicatorColor
                                          .withOpacity(0.5),
                                      width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          TabBar(
                            indicatorWeight: 6,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 45),
                            isScrollable: true,
                            unselectedLabelColor: Colors.black.withOpacity(0.5),
                            labelColor: Get.theme.colorScheme.primary,
                            indicatorColor: Get.theme.colorScheme.primary,
                            tabs: commonService.trailData
                                .mapIndexed((currentValue, index) {
                              return Tab(
                                height: 65,
                                child: currentValue.title.text
                                    .textStyle(
                                      headline2().copyWith(
                                        color: Get.theme.indicatorColor,
                                      ),
                                    )
                                    .make()
                                    .pOnly(bottom: 5),
                              );
                            }).toList(),
                            controller: controller.tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                        ],
                      )
                    : const SizedBox(
                        height: 0,
                      ),
                Expanded(
                  child: commonService.trailData.isNotEmpty
                      ? TabBarView(
                          controller: controller.tabController,
                          children: commonService.trailData
                              .mapIndexed((currentValue, index) {
                            controller.itemScrollController =
                                ItemScrollController();
                            controller.itemPositionsListener =
                                ItemPositionsListener.create();
                            return ScrollablePositionedList.builder(
                              padding: const EdgeInsets.only(bottom: 10),
                              itemCount: currentValue.locationListing.length,
                              itemScrollController:
                                  controller.itemScrollController,
                              itemPositionsListener:
                                  controller.itemPositionsListener,
                              shrinkWrap: true,
                              itemBuilder: (context, ind) {
                                LocationListing item =
                                    currentValue.locationListing.elementAt(ind);
                                return Obx(
                                  () => TrailViewWidget(
                                    onTap: () {
                                      CommonService commonService = Get.find();
                                      commonService.sameCategoryBeacons.value =
                                          [];
                                      commonService.sameCategoryBeacons
                                          .refresh();
                                      DetailController detailController =
                                          Get.find();
                                      detailController
                                          .getLocationDetailData(item.id);
                                      Get.toNamed('/detail');
                                    },
                                    bigSize: controller
                                                .firstVisibleItemIndex.value ==
                                            ind
                                        ? true
                                        : false,
                                    height: controller
                                                .firstVisibleItemIndex.value ==
                                            ind
                                        ? 240
                                        : 220,
                                    width: Get.width,
                                    attributes: item, showTitle: false, showVideoIcon: false,
                                  ).pOnly(bottom: 0),
                                );
                              },
                            );
                          }).toList(),
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                ),
              ],
            ).pOnly(bottom: 25),
          ),
          bottomNavigationBar: BottomNavWidget(
            onTap: (int index) {
              Helper.onBottomBarClick(null, index);
            },
          ),
          floatingActionButton: SpeedDialWidget(),
        ),
      ),
    );
  }
}
