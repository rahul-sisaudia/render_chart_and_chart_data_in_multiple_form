import 'package:flutter/material.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/widgets/custom_button.dart';

import '../constants/app_text_style.dart';
import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import '../helper/app_helper.dart';
import '../helper/size_helper.dart';
import '../model/pie_chart_data_model.dart';
import '../resources/assets.gen.dart';
import '../widgets/pie_chart_view_widget.dart';

class PieChartView extends StatefulWidget {
  const PieChartView({super.key});

  @override
  State<PieChartView> createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  List<PieChartDataModel> pieChartData = [];
  bool isLoading = false;
  late GlobalKey pieChartKey;

  _initializeData() async {
    setState(() {
      isLoading = true;
    });

    pieChartData = [
      (PieChartDataModel(
        x: 'Jan',
        y: 15,
        z: ColorConstants.radicalRed,
      )),
      (PieChartDataModel(
        x: 'Fab',
        y: 10,
        z: ColorConstants.purple,
      )),
      (PieChartDataModel(
        x: 'Mar',
        y: 20,
        z: ColorConstants.semiGrey,
      )),
      (PieChartDataModel(
        x: 'Apr',
        y: 20,
        z: ColorConstants.laPalma,
      )),
      (PieChartDataModel(
        x: 'May',
        y: 20,
        z: ColorConstants.grey,
      )),
    ];
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  @override
  initState() {
    pieChartKey = GlobalKey();
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
        title: Text('Pie Chart Demo',
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
                  RepaintBoundary(
                    key: pieChartKey,
                    child: PieChartViewWidget(pieChartData: pieChartData),
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
                            AppHelper.getRenderChartAsImage(pieChartKey, true);
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
                            AppHelper.getRenderPDF(pieChartKey, true);
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
                            AppHelper.getRenderChartAsExcel(pieChartData, true);
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
