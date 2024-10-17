import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/bottom_nav_controller.dart';
import 'my_icons_icons.dart';

class BottomNavWidget extends GetView {
  final Function(int)? onTap;

  const BottomNavWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavController controller= Get.put(BottomNavController());
    // Initialize your controller
    return Obx(() => BottomBarInspiredOutside(
          items: [
            TabItem(icon: Icons.phone),
            if (GetStorage().read('user_type') != "U") ...[
              TabItem(icon: Icons.home),
              TabItem(icon: MyIcons.barcode),
            ],
            if (GetStorage().read('user_type') == "U") ...[
              TabItem(icon: Icons.dialpad),
              TabItem(icon: Icons.home),
              TabItem(icon: Icons.location_on_outlined),
              TabItem(icon: MyIcons.entry),
            ],
          ],
          backgroundColor: const Color(0xffF2660F),
          color: Colors.white,
          // sizeInside: 70,
          iconSize: 30,
          colorSelected: Colors.white,
          indexSelected: controller.indexSelected.value, // Use controller value
          onTap: (int index) {
            controller.changeIndex(index); // Change index using controller
            if (onTap != null) onTap!(index);
          },
          animated: false,
          itemStyle: ItemStyle.circle,
          chipStyle: const ChipStyle(
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            background: const Color(0xffF2660F),
          ),
        ));
  }
}
