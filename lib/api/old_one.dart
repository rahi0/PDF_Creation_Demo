import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_demo/api/pdf_api.dart';

class PdfParagraphApiOLD {
  static Future<File> generate(title) async {
    final pdf = Document();

    final customFont = Font.ttf(await rootBundle.load('assets/OpenSans-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          Header(child: Text("Legend Rahi",
          style: TextStyle(
            fontSize: 24
          )
          )),
          Wrap(
            children: List<Widget>.generate(70, (index) {
              return cards();
              // Container(
              //   margin: EdgeInsets.only(top: 3),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Header(child: Text(
              //         "08 Sep, 2021",
              //         style: TextStyle(
              //           color: PdfColors.purple300,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 17
              //         )
              //         )),
                      
              //       Container(
              //     child: Wrap(
              //       children: List<Widget>.generate(index == 1 || index == 4 ? 8 : 3, (ind) {
              //       return cards();
              //       }))
              //      )
              //     ]
              //   )
              // );
            })
          )
        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: Text(
              text,
              style: TextStyle(color: PdfColors.black),
            ),
          );
        },
      ),
    );

    // pdf.addPage(
    //   MultiPage(
    //     maxPages: 200,
    //     // pageFormat: PdfPageFormat.a3,
    //     build: (context) => <Widget>[
    //       ...List<Widget>.generate(7, (index) {
    //         return Container(
    //           margin: EdgeInsets.only(top: 3),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Header(
    //                 child: Text(
    //                   "08 Sep, 2021",
    //                   style: TextStyle(
    //                       color: PdfColors.purple300,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 17),
    //                 ),
    //               ),
    //               ///////////////////////// error starts here ////////////////
    //               ...List<Widget>.generate(
    //                 8,
    //                 (ind) {
    //                   return cards();
    //                 },
    //               )
    //               ////////////////////////////////////////////////////////
    //             ],
    //           ),
    //         );
    //       })
    //     ],
    //   ),
    // );
    return PdfApi.saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Widget buildCustomHeader() => Container(
        padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
        ),
        child: Row(
          children: [
            PdfLogo(),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Text(
              'Create Your PDF',
              style: TextStyle(fontSize: 20, color: PdfColors.blue),
            ),
          ],
        ),
      );

  static Widget buildCustomHeadline() => Header(
        child: Text(
          'My Third Headline',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: PdfColors.red),
      );

  static Widget buildLink() => UrlLink(
        destination: 'https://flutter.dev',
        child: Text(
          'Go to flutter.dev',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue,
          ),
        ),
      );

  static List<Widget> buildBulletPoints() => [
        Bullet(text: 'First Bullet'),
        Bullet(text: 'Second Bullet'),
        Bullet(text: 'Third Bullet'),
      ];

  static Widget cards() => Container(
    child: Column(
      children: [
        Header(
                    child: Text(
                      "08 Sep, 2021",
                      style: TextStyle(
                          color: PdfColors.purple300,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),

                  
        Container(
        // elevation: 8.0,
        // shadowColor: Colors.grey[50].withOpacity(0.8),
        decoration: BoxDecoration(
          color: PdfColors.grey300,
          borderRadius: BorderRadius.circular(5)
        ),
        margin: EdgeInsets.only(bottom: 8),
        child: Container(
          // width: 300,
          margin: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "VISA",
                                style: TextStyle(
                                  fontSize: 16
                                )
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                "Token: 435645tRER3  Time: 12:45",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "GBP 56.07",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  // " - ${charge.refundDetails.refundedAmount}",
                                  " - 45.87",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: PdfColors.red,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            // Text(
                            //   charge.refundStatus != null && charge.refundStatus == 3 ? "refunded" : "${charge.status}",
                            //   style: AppTextStyles.textSize15.copyWith(
                            //       color: charge.refundStatus != null && charge.refundStatus == 3
                            //           ? Colors.red
                            //           : (charge.status.toUpperCase() == Charge.PAYMENT_STATUS_APPROVED)
                            //               ? Colors.green
                            //               : Colors.black54),
                            // ),
                            Text(
                              "refunded",
                              style: TextStyle(
                                  color: PdfColors.green),
                            ),
                            SizedBox(height: 5),
                            Text(
                               "Captured",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      ] )
  );
}
