// Flutter imports:
import 'package:flutter/material.dart';

class BottomTabItemModel {
  final String icon;
  final String inActiveIcon;
  final String label;
  final bool isMaterialIcon;
  final IconData? materialIcon;
  final IconData? materialIconActive;

  const BottomTabItemModel({
    required this.icon,
    required this.inActiveIcon,
    required this.label,
    this.isMaterialIcon = false,
    this.materialIcon,
    this.materialIconActive,
  });
}
