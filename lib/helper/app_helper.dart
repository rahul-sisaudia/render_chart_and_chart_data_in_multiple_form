// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:render_chart_and_chart_data_in_multiple_form/helper/size_helper.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

import '../constants/app_constants.dart';
import '../constants/app_text_style.dart';
import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import '../widgets/custom_button.dart';
import 'app_logger.dart';

class AppHelper {
  static void dismissKeyboard() {
    final currentFocus =
        FocusScope.of(AppConstants.globalNavKey.currentContext!);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void dismissSnackBar({required BuildContext ctx}) {
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
  }

  static Future<void> getRenderChartAsImage(
      dynamic cartesianChartKey, bool isPieChart) async {
    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;
    File file = File('$path/ChartImageOutput.png');
    if (isPieChart) {
      final RenderRepaintBoundary boundary =
          cartesianChartKey.currentContext.findRenderObject();

      final ui.Image image = await boundary.toImage();

      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List? pngBytes = byteData?.buffer.asUint8List();
      final Uint8List imageBytes = pngBytes!.buffer
          .asUint8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes);
      await file.writeAsBytes(imageBytes, flush: true);
    } else {
      final ui.Image data =
          await cartesianChartKey.currentState!.toImage(pixelRatio: 3.0);
      final ByteData? bytes =
          await data.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List imageBytes =
          bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      await file.writeAsBytes(imageBytes, flush: true);
    }

    OpenFile.open('$path/ChartImageOutput.png');
  }

  static Future<void> getRenderPDF(
      dynamic cartesianChartKey, isPieChart) async {
    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;
    File file = File('$path/ChartPdfOutput.pdf');
    final List<int> imageBytes =
        await _readImageData(cartesianChartKey, isPieChart);
    final PdfBitmap bitmap = PdfBitmap(imageBytes);
    final PdfDocument document = PdfDocument();
    if (isPieChart) {
      document.pageSettings.orientation = PdfPageOrientation.landscape;
    }

    document.pageSettings.size =
        Size(bitmap.width.toDouble(), bitmap.height.toDouble());
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();
    page.graphics.drawImage(
        bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    final List<int> bytes = document.saveSync();
    document.dispose();

    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/ChartPdfOutput.pdf');
  }

  static Future<List<int>> _readImageData(cartesianChartKey, isPieChart) async {
    if (isPieChart) {
      final RenderRepaintBoundary boundary =
          cartesianChartKey.currentContext.findRenderObject();

      final ui.Image image = await boundary.toImage();

      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes!.buffer
          .asUint8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes);
    } else {
      final ui.Image data =
          await cartesianChartKey.currentState!.toImage(pixelRatio: 3.0);
      final ByteData? bytes =
          await data.toByteData(format: ui.ImageByteFormat.png);

      return bytes!.buffer
          .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    }
  }

  static Future<void> getRenderChartAsExcel(
      List<dynamic> data, bool isLineChart) async {
    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];

    if (!isLineChart) {
      sheet.getRangeByIndex(1, 1).setText("Sr.");
      sheet.getRangeByIndex(1, 2).setText("Pending");
      sheet.getRangeByIndex(1, 3).setText("Resolve-Requested");
      sheet.getRangeByIndex(1, 4).setText("Resolve");
      sheet.getRangeByIndex(1, 5).setText("Closed");
      sheet.autoFitColumn(3);

      for (var i = 0; i < data.length; i++) {
        final item = data[i];
        sheet.getRangeByIndex(i + 2, 1).setText(item.x);
        sheet.getRangeByIndex(i + 2, 2).setText(item.y1.toString());
        sheet.getRangeByIndex(i + 2, 3).setText(item.y2.toString());
        sheet.getRangeByIndex(i + 2, 4).setText(item.y3.toString());
        sheet.getRangeByIndex(i + 2, 5).setText(item.y4.toString());
      }
      final List<int> bytes = workbook.saveAsStream();
      File file = File('$path/BarChartOutput.xlsx');
      await file.writeAsBytes(bytes, flush: true);

      await OpenFile.open('$path/BarChartOutput.xlsx');
      AppLogger.log('data list :${file.lengthSync()}');
    } else {
      sheet.getRangeByIndex(1, 1).setText("Month");
      sheet.getRangeByIndex(1, 2).setText("         Value         ");
      sheet.autoFitColumn(2);

      for (var i = 0; i < data.length; i++) {
        final item = data[i];
        sheet.getRangeByIndex(i + 2, 1).setText(item.x);
        sheet.getRangeByIndex(i + 2, 2).setText(item.y.toString());
      }
      final List<int> bytes = workbook.saveAsStream();
      File file = File('$path/LineChartOutput.xlsx');
      await file.writeAsBytes(bytes, flush: true);

      await OpenFile.open('$path/LineChartOutput.xlsx');
    }
    workbook.dispose();
  }

  static Future<void> showSimpleDialogue<T>({
    bool showOkayButton = false,
    bool showIcon = false,
    bool showNoButton = false,
    String cancelBtnTitle = 'cancel',
    String okBtnTitle = 'Ok',
    String title = 'Alert',
    String message = '',
    final VoidCallback? onTap,
  }) async {
    await showDialog<T>(
      barrierDismissible: false,
      context: AppConstants.globalNavKey.currentContext!,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: SizeHelper.getDeviceWidth(context) / Dimensions.px1,
                decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(Dimensions.px10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.px20, horizontal: Dimensions.px20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: Dimensions.px20),
                      if (showIcon)
                        const Icon(Icons.done,
                            size: Dimensions.px40,
                            color: ColorConstants.radicalRed),
                      const SizedBox(height: Dimensions.px10),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBoldText(
                          fontSize: Dimensions.px22,
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.px10,
                      ),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regularText(
                          fontSize: Dimensions.px16,
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.px15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (showNoButton)
                            Expanded(
                              child: CustomButton(
                                  height: Dimensions.px45,
                                  style: AppTextStyles.semiBoldText(
                                      fontSize: Dimensions.px16,
                                      color: ColorConstants.white),
                                  label: cancelBtnTitle,
                                  btnColor: ColorConstants.grey,
                                  onTap: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                          if (showOkayButton && showNoButton) SizeHelper.w2(),
                          if (showOkayButton)
                            Expanded(
                              child: CustomButton(
                                height: Dimensions.px45,
                                style: AppTextStyles.semiBoldText(
                                    fontSize: Dimensions.px16,
                                    color: ColorConstants.white),
                                label: okBtnTitle,
                                btnColor: ColorConstants.mercury,
                                onTap: onTap,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.px10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
