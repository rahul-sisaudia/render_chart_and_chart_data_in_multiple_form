import 'package:flutter/material.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/constants/app_constants.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/view/common_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: AppConstants.globalNavKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CommonView(),
    );
  }
}
