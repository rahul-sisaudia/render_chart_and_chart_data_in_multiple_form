import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/app_text_style.dart';
import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import '../helper/size_helper.dart';
import '../model/pie_chart_data_model.dart';

class PieChartViewWidget extends StatelessWidget {
  final List<PieChartDataModel> pieChartData;

  const PieChartViewWidget({Key? key, required this.pieChartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.px15, horizontal: Dimensions.px5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.px10),
        color: ColorConstants.white,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(Dimensions.px5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstants.downPink),
            height: Dimensions.px150,
            width: Dimensions.px150,
            child: SfCircularChart(series: <CircularSeries>[
              PieSeries<PieChartDataModel, String>(
                dataSource: pieChartData,
                xValueMapper: (PieChartDataModel data, _) => data.x,
                yValueMapper: (PieChartDataModel data, _) => data.y,
                pointColorMapper: (PieChartDataModel data, _) => data.z,
                radius: '125%',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                ),
              )
            ]),
          ),
          SizeHelper.w1(),
          Expanded(
            flex: 5,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: pieChartData.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildRowTextView(
                    title: pieChartData[index].x.toString(),
                  );
                }),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: pieChartData.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildRowTextView(
                    title: ':${pieChartData[index].y.toString()}',
                  );
                }),
          ),
        ],
      ),
    );
  }

  _buildRowTextView({
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textScaleFactor: 0.85,
          textAlign: TextAlign.center,
          style: AppTextStyles.regularText(fontSize: Dimensions.px12),
        ),
        SizeHelper.h1(),
      ],
    );
  }
}
