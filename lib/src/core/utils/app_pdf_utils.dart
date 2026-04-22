// Dart imports:
import 'dart:io';

// Package imports:
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfUtilities {
  static Future<File> saveDocumentAsFile({
    required String name,
    required Document document,
  }) async {
    final bytes = await document.save();
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    String? dir = directory?.path;
    final assetsDir = '$dir/Invoices';

    final filePath = assetsDir;

    final savedDir = Directory(filePath);

    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create(recursive: true);
    }
    final file = File('$filePath/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future printPdf(String name, {required Document document}) async {
    return await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => document.save());
  }
}

// class PdfGenerator {
//   static Future<pw.Document> generateReceipt(
//     TransactionModel transaction,
//     BuildContext buildContext,
//   ) async {
//     final pdf = pw.Document();
//     //String logo = await rootBundle.loadString('assets/icons/client.svg');
//     final String image = await rootBundle.loadString(AppImages.logo);

//     // Uint8List image = (pngLogo).buffer.asUint8List();

//     final ttfIcon = await PdfGoogleFonts.materialIconsRegular();
//     final currencyFontBold = await PdfGoogleFonts.interBold();
//     final font = await rootBundle.load("assets/fonts/mona-sans-medium.ttf");
//     final ttf = pw.Font.ttf(font);
//     final fontBold = await rootBundle.load("assets/fonts/mona-sans-medium.ttf");
//     final ttfBold = pw.Font.ttf(fontBold);

//     // Future<pw.Font> loadMaterialIconFont() async {
//     final icon = await rootBundle.load('assets/fonts/mona-sans.ttf');
//     final iconData = pw.Font.ttf(icon);
//     //   return pw.Font.ttf(fontData.buffer.asByteData());
//     // }
//     // final fontIcon = await rootBundle.load("assets/fonts/IconlyBold.ttf");
//     // final ttfIcon = pw.Font.ttf(fontIcon);
//     final pw.ThemeData theme = pw.ThemeData.withFont(
//       base: ttf,
//       bold: ttfBold,
//       icons: ttfIcon,
//     );

//     pdf.addPage(pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         theme: theme,
//         build: (pw.Context context) => [
//               buildReceiptHeader(image, transaction, buildContext),

//               pw.SizedBox(height: 2 * PdfPageFormat.cm),
//               buildReceiptBody(
//                   transaction, buildContext, currencyFontBold, iconData),
//               pw.SizedBox(height: 8 * PdfPageFormat.mm),

//               pw.SizedBox(height: 1 * PdfPageFormat.mm),

//               pw.SizedBox(height: 5 * PdfPageFormat.mm),
//               pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: []),

//               pw.SizedBox(height: 2 * PdfPageFormat.mm),

//               //  buildBusinessDetails(businessViewModel),
//               // pw.SizedBox(height: 2 * PdfPageFormat.mm),
//               // pw.Spacer(),
//             ],
//         footer: (pw.Context context) => buildFooter())); // Page
//     // return PdfUtilities.saveDocument(
//     //     name: 'Billing Invoice - ${invoice.refNumber}.pdf', document: pdf);
//     return pdf;
//   }
// }

// pw.Widget buildFooter() => pw.Column(children: [
//       pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
//         pw.Divider(color: PdfColor.fromHex('000000')),
//         pw.SizedBox(height: 2 * PdfPageFormat.mm),
//         pw.Text(
//           '© ${DateTime.now().year} Milarn',
//           style: pw.TextStyle(
//             color: PdfColors.grey,
//             fontWeight: pw.FontWeight.bold,
//             fontSize: 14,
//           ),
//         )
//       ]),
//     ]);

// pw.Widget buildReceiptHeader(
//         image, TransactionModel transaction, BuildContext context) =>
//     pw.Container(
//         // color: PdfColor.fromHex("000000"),
//         padding: const pw.EdgeInsets.only(left: 20, right: 20),
//         child: pw.Column(children: [
//           pw.SizedBox(height: 3 * PdfPageFormat.mm),
//           pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 // pw.SvgImage(svg: milarnLogo),
//                 pw.SvgImage(svg: image, height: 110, width: 110),
//               ]),
//           // pw.SizedBox(height: 3 * PdfPageFormat.mm),
//         ]));

// pw.Widget buildReceiptBody(
//     TransactionModel transaction, BuildContext context, font, iconFont) {
//   List<String> leading = [
//     'Withdrawal Amount:',
//     'Description:',
//     // 'Transaction Charges:',
//     if (transaction.metadata != null) ...[
//       'Account Number',
//       'Bank',
//       'Account Name',
//     ],
//     'Reference'
//   ];

//   List<String> traling = [
//     HelperFunctions.formatAmount(amount: transaction.amount ?? 0),
//     // HelperFunctions.formatAmount(
//     //     amount: historyState.transactionDetailResponse?.data?.amount ?? 0),
//     '${transaction.description}',
//     if (transaction.metadata != null) ...[
//       '${transaction.metadata?.accountNumber}',
//       '${transaction.metadata?.bankName}',
//       '${transaction.metadata?.accountName}',
//     ],
//     transaction.ref ?? "",
//   ];
//   return pw.Column(
//       mainAxisAlignment: pw.MainAxisAlignment.center,
//       crossAxisAlignment: pw.CrossAxisAlignment.center,
//       children: [
//         pw.SizedBox(height: 10),
//         pw.Container(
//           padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           decoration: pw.BoxDecoration(
//             color: PdfColors.grey100,
//             borderRadius: pw.BorderRadius.circular(16.r),
//           ),
//           child: pw.Column(children: [
//             pw.Center(
//               child: pw.RichText(
//                 text: pw.TextSpan(
//                   children: [
//                     pw.TextSpan(
//                       text: "₦",
//                       style: pw.TextStyle(
//                         font: font,
//                         fontSize: 30.sp,
//                         //THE FONT FAMILY MUST BE INTER, ON ANDROID THE "₦" SYMBOL
//                         //IS NOT SUPPORTED FOR THE MON SANS FONT
//                       ),
//                     ),
//                     pw.TextSpan(
//                       text: HelperFunctions.formatAmount(
//                           amount: transaction.amount ?? 0),
//                       style: pw.TextStyle(
//                         color: PdfColor.fromHex('000000'),
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 30.sp,
//                         // font: font
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             pw.Center(
//                 child: pw.Text(
//                     "${HelperFunctions.formatDate(dateTime: DateTime.parse(transaction.date!), dateFormat: 'MMM dd, yyyy hh:mm:ss')}",
//                     style: pw.TextStyle(
//                       fontSize: 13.sp,
//                       font: font,
//                       // fontFallback: ['Mona'],
//                       fontWeight: pw.FontWeight.normal,
//                     ))),
//           ]),
//         ),
//         pw.SizedBox(height: 25),
//         pw.Container(
//           // width: 350.w,
//           padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           decoration: pw.BoxDecoration(
//             color: PdfColors.grey100,
//             borderRadius: pw.BorderRadius.circular(16.r),
//           ),

//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text('Transaction Details',
//                   style: pw.TextStyle(
//                     fontSize: 14.sp,
//                     font: font,
//                     // fontFallback: ['Mona'],
//                     fontWeight: pw.FontWeight.bold,
//                   )),
//               pw.SizedBox(height: 25),
//               // Spacing.height(18.h),
//               pw.ListView.separated(
//                 itemBuilder: (context, index) {
//                   return pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Text(
//                         leading[index],
//                         style: pw.TextStyle(
//                           // fontFamily: 'Mona',
//                           fontWeight: pw.FontWeight.bold,
//                         ).copyWith(
//                           fontSize: 13.sp,
//                         ),
//                       ),
//                       pw.SizedBox(width: 20.w),
//                       //USE THIS WIDGET FOR THE AMOUNTS
//                       //TO DISPLAY THE CURRENCY
//                       if (index == 0)
//                         pw.Text(
//                           "₦${traling[index]}",
//                           style: pw.TextStyle(
//                             fontSize: 12.sp,
//                             font: font,
//                             // fontFallback: ['Mona'],
//                             fontWeight: pw.FontWeight.normal,
//                           ),
//                           // style: AppTextStyle.bodySmall.copyWith(
//                           //     fontSize: 12.sp, fontWeight: FontWeight.w400),
//                         )
//                       else
//                         pw.Flexible(
//                             child: pw.Text(
//                           traling[index],
//                           // width: 180.w,
//                           overflow: pw.TextOverflow.visible,
//                           style: pw.TextStyle(
//                             fontSize: 12.sp,
//                             font: font,
//                             // fontFallback: ['Mona'],
//                             fontWeight: pw.FontWeight.normal,
//                           ),
//                           // style: AppTextStyle.titleSmall.copyWith(
//                           //     fontSize: 11.sp, fontWeight: FontWeight.w400),
//                           textAlign: TextAlign.end,
//                         )),
//                     ],
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return pw.SizedBox(height: 14.h);
//                 },
//                 itemCount: leading.length,
//               )
//             ],
//           ),
//         ),
//       ]);
// }
