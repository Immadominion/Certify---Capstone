// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';

class CertifyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
