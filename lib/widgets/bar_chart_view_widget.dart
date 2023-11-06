import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/app_text_style.dart';
import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import '../model/bar_chart_data_model.dart';

class BarChartViewWidget extends StatelessWidget {
  final dynamic toolTip;
  final bool isShowHeader;
  final bool inTabBar;
  final double? maximumPoint;
  final double? intervalPoint;
  final List<BarChartDataModel> chartData;

  const BarChartViewWidget(
      {Key? key,
      this.isShowHeader = false,
      this.toolTip,
      this.intervalPoint,
      this.maximumPoint,
      this.inTabBar = false,
      required this.chartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: inTabBar
            ? const BorderRadius.only(
                bottomRight: Radius.circular(Dimensions.px10),
                bottomLeft: Radius.circular(Dimensions.px10))
            : const BorderRadius.all(Radius.circular(Dimensions.px10)),
        color: ColorConstants.white,
      ),
      child: SfCartesianChart(
        onTooltipRender: (TooltipArgs args) {
          if (args.seriesIndex == 3) {
            args.header = 'Pending';
          }
          if (args.seriesIndex == 2) {
            args.header = 'Resolve Requested';
          }
          if (args.seriesIndex == 1) {
            args.header = 'Resolved';
          }
          if (args.seriesIndex == 0) {
            args.header = 'Closed';
          }
        },
        key: key,
        tooltipBehavior: toolTip,
        primaryXAxis: CategoryAxis(
            majorGridLines:
                MajorGridLines(color: ColorConstants.grey.withOpacity(0.5)),
            isVisible: true,
            labelStyle: AppTextStyles.semiBoldText(fontSize: Dimensions.px8)),
        primaryYAxis: NumericAxis(
            majorGridLines:
                MajorGridLines(color: ColorConstants.grey.withOpacity(0.5)),
            minimum: Dimensions.px0,
            maximum: maximumPoint?.roundToDouble(),
            interval: intervalPoint?.roundToDouble().abs(),
            labelStyle: AppTextStyles.semiBoldText(fontSize: Dimensions.px10),
            axisLine: AxisLine(color: Colors.grey.withOpacity(0.5))),
        series: <ChartSeries<BarChartDataModel, String>>[
          StackedColumnSeries<BarChartDataModel, String>(
              color: ColorConstants.green,
              dataSource: chartData,
              xValueMapper: (BarChartDataModel data, _) => data.x,
              yValueMapper: (BarChartDataModel data, _) => data.y4),
          StackedColumnSeries<BarChartDataModel, String>(
              color: ColorConstants.black30,
              dataSource: chartData,
              xValueMapper: (BarChartDataModel data, _) => data.x,
              yValueMapper: (BarChartDataModel data, _) => data.y3),
          StackedColumnSeries<BarChartDataModel, String>(
              color: ColorConstants.laPalma,
              dataSource: chartData,
              xValueMapper: (BarChartDataModel data, _) => data.x,
              yValueMapper: (BarChartDataModel data, _) => data.y2),
          StackedColumnSeries<BarChartDataModel, String>(
              enableTooltip: true,
              color: ColorConstants.radicalRed,
              dataSource: chartData,
              xValueMapper: (BarChartDataModel data, _) => data.x,
              yValueMapper: (BarChartDataModel data, _) => data.y1),
        ],
      ),
    );
  }
}
