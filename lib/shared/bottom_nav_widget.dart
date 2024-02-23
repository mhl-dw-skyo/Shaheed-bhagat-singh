import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core.dart';

class BottomNavWidget extends StatelessWidget {
  final Function(int) onTap;
  const BottomNavWidget({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBarInspiredOutside(
      height: 40,
      items: [
        TabItem(
          icon: SvgPicture.asset(
            "assets/images/sos.svg",
            width: 30,
            height: 30,
          ),
        ),
        if (GetStorage().read('user_type') != "U")
          TabItem(
              icon: SvgPicture.asset(
            "assets/images/barcode.svg",
            width: 30,
            height: 30,
            color: Colors.white,
          )),
        if (GetStorage().read('user_type') == "U") ...[
          TabItem(
            icon: SvgPicture.asset(
              "assets/images/dialpad.svg",
              width: 30,
              height: 30,
              color: Colors.white,
            ),
          ),
          TabItem(
            icon: SvgPicture.asset(
              "assets/images/map.svg",
              width: 30,
              height: 30,
            ),
          ),
          TabItem(
              icon: SvgPicture.asset(
            "assets/images/entry.svg",
            color: Colors.white,
            width: 40,
            height: 40,
          )),
        ],
        TabItem(
          icon: SvgPicture.asset(
            "assets/images/home.svg",
            width: 30,
            height: 30,
          ),
        ),
      ],
      sizeInside: 65,
      backgroundColor: Colors.transparent,
      color: Colors.white,
      colorSelected: Colors.white,
      indexSelected: GetStorage().read('user_type') != "U" ? 1 : 2,
      top: -50,
      onTap: onTap,
      animated: false,
      itemStyle: ItemStyle.circle,
      chipStyle: const ChipStyle(
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        background: Colors.transparent,
      ),
    );
  }
}
