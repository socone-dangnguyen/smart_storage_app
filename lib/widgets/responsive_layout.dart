import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget tiny;
  final Widget phone;
  final Widget largeTablet;
  final Widget computer;

  const ResponsiveLayout({
    required this.tiny,
    required this.phone,
    required this.largeTablet,
    required this.computer,
  });

  static final int tinyHeightLimit = 100;
  static final int tinyLimit = 270;
  static final int phoneLimit = 550;
  static final int largeTabletLimit = 1100;

  static bool isTinyHeightLimit(BuildContext context) =>
      MediaQuery.of(context).size.height < tinyHeightLimit;

  static bool isTinyLimit(BuildContext context) =>
      MediaQuery.of(context).size.width < tinyLimit;

  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < phoneLimit &&
          MediaQuery.of(context).size.width >= tinyLimit;

  static bool isLargeTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < largeTabletLimit &&
          MediaQuery.of(context).size.width >= phoneLimit;

  static bool isComputer(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeTabletLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < tinyLimit ||
            constraints.maxHeight < tinyHeightLimit) {
          return tiny;
        }
        if (constraints.maxWidth < phoneLimit) {
          return phone;
        }
        if (constraints.maxWidth < largeTabletLimit) {
          return largeTablet;
        } else {
          return computer;
        }
      },
    );
  }
}