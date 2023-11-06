import 'package:flutter/material.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/widgets/custom_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/app_text_style.dart';
import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import '../helper/app_helper.dart';
import '../helper/size_helper.dart';
import '../model/bar_chart_data_model.dart';
import '../resources/assets.gen.dart';
import '../widgets/bar_chart_view_widget.dart';

class BarChartView extends StatefulWidget {
  const BarChartView({super.key});

  @override
  State<BarChartView> createState() => _BarChartViewState();
}

class _BarChartViewState extends State<BarChartView> {
  List<BarChartDataModel> barChartData = [];
  bool isLoading = false;
  late GlobalKey<SfCartesianChartState> barChartKey;
  late TooltipBehavior barChartToolTipBehavior;

  _initializeData() async {
    setState(() {
      isLoading = true;
    });

    barChartData = [
      (BarChartDataModel(x: '1', y1: 5, y2: 11, y3: 15, y4: 8)),
      (BarChartDataModel(x: '2', y1: 15, y2: 17, y3: 8, y4: 2)),
      (BarChartDataModel(x: '3', y1: 20, y2: 18, y3: 9, y4: 6)),
      (BarChartDataModel(x: '4', y1: 8, y2: 9, y3: 2, y4: 10)),
      (BarChartDataModel(x: '5', y1: 15, y2: 9, y3: 7, y4: 4))
    ];
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  @override
  initState() {
    barChartKey = GlobalKey();
    barChartToolTipBehavior = TooltipBehavior(
      enable: true,
      tooltipPosition: TooltipPosition.pointer,
    );
    _initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: ColorConstants.radicalRed,
          ),
        ),
        title: Text('Bar Chart Demo',
            style: AppTextStyles.boldText(
                fontSize: Dimensions.px20, color: ColorConstants.radicalRed)),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.radicalRed,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.px10, vertical: Dimensions.px10),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BarChartViewWidget(
                    maximumPoint: Dimensions.px60,
                    intervalPoint: Dimensions.px10,
                    key: barChartKey,
                    chartData: barChartData,
                    toolTip: barChartToolTipBehavior,
                  ),
                  SizeHelper.h2(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Download as',
                        style: AppTextStyles.boldText(
                            fontSize: Dimensions.px22,
                            color: ColorConstants.radicalRed),
                      ),
                      MyAssets.download.svg(),
                    ],
                  ),
                  SizeHelper.h2(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            AppHelper.getRenderChartAsImage(barChartKey, false);
                          },
                          label: 'PNG Image',
                          style: AppTextStyles.semiBoldText(
                              fontSize: Dimensions.px16,
                              color: ColorConstants.white),
                          iconWidget: MyAssets.png_file.svg(),
                        ),
                      ),
                      SizeHelper.w2(),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            AppHelper.getRenderPDF(barChartKey, false);
                          },
                          label: 'PDF File',
                          style: AppTextStyles.semiBoldText(
                              fontSize: Dimensions.px16,
                              color: ColorConstants.white),
                          iconWidget: MyAssets.pdf_file.svg(),
                        ),
                      ),
                    ],
                  ),
                  SizeHelper.h1(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            AppHelper.getRenderChartAsExcel(
                                barChartData, false);
                          },
                          label: 'Excel (xls)',
                          style: AppTextStyles.semiBoldText(
                              fontSize: Dimensions.px16,
                              color: ColorConstants.white),
                          iconWidget: MyAssets.xls_file.svg(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
