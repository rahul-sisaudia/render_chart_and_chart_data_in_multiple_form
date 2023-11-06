import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/app_text_style.dart';
import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import '../helper/app_helper.dart';
import '../helper/app_logger.dart';
import '../helper/size_helper.dart';
import '../resources/assets.gen.dart';
import 'custom_button.dart';

Future commonDownloadOptionBottomSheetView(
  dynamic cartesianChartKey,
  dynamic list,
  bool isLineChart,
  bool isPieChart,
) {
  return showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.px10),
              topRight: Radius.circular(Dimensions.px10))),
      backgroundColor: Colors.white,
      context: AppConstants.globalNavKey.currentContext!,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: Dimensions.px300,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.px20, horizontal: Dimensions.px20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizeHelper.w5(),
                      Text(
                        'Download Options',
                        style: AppTextStyles.semiBoldText(
                          fontSize: Dimensions.px23,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Close',
                          style: AppTextStyles.semiBoldText(
                              fontSize: Dimensions.px16),
                        ),
                      ),
                    ],
                  ),
                  SizeHelper.h4(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            isExpanded: true,
                            iconWidget: MyAssets.png_file.svg(),
                            label: 'Image (png)',
                            btnColor: ColorConstants.grey,
                            style: AppTextStyles.semiBoldText(
                                fontSize: Dimensions.px16,
                                color: ColorConstants.white),
                            onTap: () {
                              AppLogger.log('image PNG download tapped');
                              AppHelper.getRenderChartAsImage(
                                  cartesianChartKey, isPieChart);
                            }),
                      ),
                      SizeHelper.w1(),
                      Expanded(
                        child: CustomButton(
                            isExpanded: true,
                            iconWidget: MyAssets.pdf_file.svg(),
                            label: 'Vector (svg)',
                            btnColor: ColorConstants.green,
                            style: AppTextStyles.semiBoldText(
                                fontSize: Dimensions.px16,
                                color: ColorConstants.white),
                            onTap: () {
                              AppLogger.log('vector download btn tapped');
                            }),
                      ),
                    ],
                  ),
                  SizeHelper.h2(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            isExpanded: true,
                            iconWidget: MyAssets.pdf_file.svg(),
                            label: 'Document (pdf)',
                            btnColor: ColorConstants.grey,
                            style: AppTextStyles.semiBoldText(
                                fontSize: Dimensions.px16,
                                color: ColorConstants.white),
                            onTap: () {
                              AppHelper.getRenderPDF(
                                  cartesianChartKey, isPieChart);
                            }),
                      ),
                      SizeHelper.w1(),
                      Expanded(
                        child: CustomButton(
                            isExpanded: true,
                            iconWidget: MyAssets.xls_file.svg(),
                            label: 'Excel (Xls)',
                            btnColor: ColorConstants.green,
                            style: AppTextStyles.semiBoldText(
                              fontSize: Dimensions.px16,
                              color: ColorConstants.white,
                            ),
                            onTap: () {
                              AppLogger.log('excel download btn tapped');
                              AppHelper.getRenderChartAsExcel(
                                  list, isLineChart);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}
