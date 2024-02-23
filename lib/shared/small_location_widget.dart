import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core.dart';

class SmallLocationViewWidget extends StatelessWidget {
  final LocationModel data;
  final Function(int) onTap;
  const SmallLocationViewWidget({
    Key key,
    this.data,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          data.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    ).pOnly(right: 20);
  }
}
