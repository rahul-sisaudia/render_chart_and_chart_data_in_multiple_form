import 'package:flutter/material.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/model/line_chart_data_model.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/widgets/custom_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/app_text_style.dart';
import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import '../helper/app_helper.dart';
import '../helper/size_helper.dart';
import '../resources/assets.gen.dart';
import '../widgets/line_chart_view_widget.dart';

class LineChartView extends StatefulWidget {
  const LineChartView({super.key});

  @override
  State<LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<LineChartView> {
  List<LineChartDataModel> lineChartData = [];
  bool isLoading = false;
  late GlobalKey<SfCartesianChartState> lineChartKey;
  late TooltipBehavior lineChartToolTipBehavior;

  _initializeData() async {
    setState(() {
      isLoading = true;
    });

    lineChartData = [
      (LineChartDataModel(x: 'Jan', y: 10)),
      (LineChartDataModel(x: 'Fab', y: 40)),
      (LineChartDataModel(x: 'Mar', y: 30)),
      (LineChartDataModel(x: 'Apr', y: 50)),
      (LineChartDataModel(x: 'May', y: 5)),
    ];
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  @override
  initState() {
    lineChartKey = GlobalKey();
    lineChartToolTipBehavior = TooltipBehavior(
      enable: true,
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
        title: Text('Line Chart Demo',
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
                  LineChartViewWidget(
                    maximumPoint: Dimensions.px60,
                    intervalPoint: Dimensions.px10,
                    key: lineChartKey,
                    lineChartData: lineChartData,
                    toolTip: lineChartToolTipBehavior,
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
                            AppHelper.getRenderChartAsImage(
                                lineChartKey, false);
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
                            AppHelper.getRenderPDF(lineChartKey, false);
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
                                lineChartData, true);
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
