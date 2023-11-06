import 'package:flutter/widgets.dart';

class SizeHelper {
  static double getDeviceHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height;
  }

  static double getDeviceWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width;
  }

  static Widget h05() => const SizedBox(height: 5);

  static Widget h1() => const SizedBox(height: 10);

  static Widget h15() => const SizedBox(height: 15);

  static Widget h2() => const SizedBox(height: 20);

  static Widget h3() => const SizedBox(height: 30);

  static Widget h4() => const SizedBox(height: 40);

  static Widget h5() => const SizedBox(height: 50);

  static Widget h8() => const SizedBox(height: 80);

  static Widget h6() => const SizedBox(height: 60);

  static Widget h7() => const SizedBox(height: 70);

  static Widget h10() => const SizedBox(height: 100);

  static Widget h12() => const SizedBox(height: 120);

  static Widget h14() => const SizedBox(height: 140);

  static Widget h20() => const SizedBox(height: 200);

  static Widget w05() => const SizedBox(width: 5);

  static Widget w1() => const SizedBox(width: 10);

  static Widget w3() => const SizedBox(width: 30);

  static Widget w5() => const SizedBox(width: 50);

  static Widget w015() => const SizedBox(width: 15);

  static Widget w2() => const SizedBox(width: 20);

  static Widget w4() => const SizedBox(width: 40);

  static Widget w6() => const SizedBox(width: 60);

  static Widget w8() => const SizedBox(width: 80);
}
