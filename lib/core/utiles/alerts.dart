import 'package:flutter/material.dart';

class OverLays {
  static Future dialog(BuildContext context,
      {required Widget child,
      RouteSettings? routeSettings,
      EdgeInsets? insetPadding,
      AlignmentGeometry? alignment,
      Color? backgroundColor}) {
    return showDialog(
        context: context,
        routeSettings: routeSettings,
        builder: (context) => Dialog(
              backgroundColor: backgroundColor,
              insetPadding: insetPadding,
              alignment: alignment,
              child: child,
            ));
  }
}
