import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import '../model/line_chart_data_model.dart';

class LineChartViewWidget extends StatelessWidget {
  final List<LineChartDataModel> lineChartData;
  final dynamic maximumPoint;
  final dynamic intervalPoint;
  final dynamic toolTip;

  const LineChartViewWidget(
      {Key? key,
      required this.lineChartData,
      required this.toolTip,
      this.maximumPoint,
      this.intervalPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.px10, vertical: Dimensions.px10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.px10),
        color: ColorConstants.white,
      ),
      child: SfCartesianChart(
        key: key,
        tooltipBehavior: toolTip,
        primaryYAxis: NumericAxis(
            minimum: Dimensions.px0,
            maximum: maximumPoint,
            interval: intervalPoint?.roundToDouble().abs() ?? Dimensions.px20,
            axisLine: const AxisLine(color: ColorConstants.radicalRed)),
        primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(color: ColorConstants.white)),
        series: <ChartSeries>[
          LineSeries<LineChartDataModel, String>(
              color: ColorConstants.radicalRed,
              markerSettings: const MarkerSettings(
                color: ColorConstants.radicalRed,
                isVisible: true,
                borderColor: ColorConstants.radicalRed,
              ),
              enableTooltip: true,
              dataSource: lineChartData,
              xValueMapper: (LineChartDataModel data, _) => data.x,
              yValueMapper: (LineChartDataModel data, _) => data.y)
        ],
      ),
    );
  }
}
