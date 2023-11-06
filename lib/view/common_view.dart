import 'package:flutter/material.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/constants/app_text_style.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/constants/color_constants.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/constants/dimension_constants.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/helper/routing_helper.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/helper/size_helper.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/resources/assets.gen.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/view/bar_chart_view.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/view/line_chart_view.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/view/pie_chart_view.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/widgets/custom_button.dart';

class CommonView extends StatelessWidget {
  const CommonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Chart Demo',
            style: AppTextStyles.boldText(
                fontSize: Dimensions.px24, color: ColorConstants.radicalRed)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.px10, vertical: Dimensions.px20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyAssets.png_file.svg(
                  height: Dimensions.px80,
                  colorFilter: const ColorFilter.mode(
                      ColorConstants.radicalRed, BlendMode.srcIn),
                ),
                MyAssets.pdf_file.svg(
                    height: Dimensions.px80,
                    colorFilter: const ColorFilter.mode(
                        ColorConstants.radicalRed, BlendMode.srcIn)),
                MyAssets.xls_file.svg(
                    height: Dimensions.px80,
                    colorFilter: const ColorFilter.mode(
                        ColorConstants.radicalRed, BlendMode.srcIn)),
              ],
            ),
            SizeHelper.h4(),
            CustomButton(
              isEnabled: true,
              label: 'Show Bar Chart View',
              onTap: () {
                RoutingHelper.pushToScreen(screen: const BarChartView());
              },
            ),
            SizeHelper.h2(),
            CustomButton(
              isEnabled: true,
              label: 'Show Line Chart View',
              onTap: () {
                RoutingHelper.pushToScreen(screen: const LineChartView());
              },
            ),
            SizeHelper.h2(),
            CustomButton(
              isEnabled: true,
              label: 'Show Pie Chart View',
              onTap: () {
                RoutingHelper.pushToScreen(screen: const PieChartView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
