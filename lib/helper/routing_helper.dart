import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// A convenient class wraps all functions of **RoutingHelper**
class RoutingHelper {
  /// this is a customize user define function
  /// this take some required input's for build and show bottomSheet
  /// and return the widget

  static void buildAndShowModalBottomSheetFor({
    bool isScrollControlled = true,
    required Widget widget,
  }) {
    showModalBottomSheet(
        isScrollControlled: isScrollControlled,

        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
        backgroundColor: Colors.white,
        context: AppConstants.globalNavKey.currentContext!,
        builder: (_) {
          return widget;
        });
  }

  /// this function is used for navigate the screen's
  /// it takes two inputs ctx and class name for navigating
  /// Push the given route onto the navigator,
  /// and then remove all the previous routes until the predicate returns true.
  static void pushAndRemoveUntilToScreen({
    required Widget screen,
  }) {
    final route = MaterialPageRoute(
      builder: (ctx) => screen,
    );
    Navigator.pushAndRemoveUntil(
        AppConstants.globalNavKey.currentContext!, route, (route) => false);
  }

  /// this function is used for navigate the screen's
  /// it takes two inputs ctx and class name for navigating
  /// Push the given route onto the navigator,
  /// and not remove all the previous routes.
  static void pushToScreen({
    bool fullscreenDialog = false,
    required Widget screen,
  }) {
    final route = MaterialPageRoute(
      builder: (ctx) => screen,
      fullscreenDialog: fullscreenDialog,
    );
    Navigator.push(AppConstants.globalNavKey.currentContext!, route);
  }
}
