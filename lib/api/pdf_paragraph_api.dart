import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_demo/api/pdf_api.dart';

class PdfParagraphApi {
  static Future<File> generate(allTransactions) async {
    final pdf = Document();

    final customFont = Font.ttf(await rootBundle.load('assets/OpenSans-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          buildCustomHeader(),
          Wrap(
              children: List<Widget>.generate(allTransactions.length, (index) {
            return cards(allTransactions[index], index);
          }))
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
    return PdfApi.saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Widget cards(transactionData, index) => Container(
        decoration: BoxDecoration(
          color: index % 2 == 0 ? PdfColors.grey300 : PdfColors.white,
        ),
        child: Container(
          // width: 300,
          margin: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  // margin: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: columCon(
                            "Token: ${transactionData['order_id'].substring((transactionData['order_id'].length - 8))}",
                            "Date: ${transactionData['date_only']}"),
                      ),
                      Flexible(
                        child: columCon(
                            "${transactionData['payment_details']['card_type'].toUpperCase()}", 
                            transactionData['refund_status'] != null && transactionData['refund_status'] == 3 ? "refunded" : "${transactionData['status']}"),
                      ),
                      Flexible(
                        child: columCon("${transactionData['currency']} ${transactionData['total_amount'].toStringAsFixed(2)}",
                            transactionData['refund_status'] != null && transactionData['refund_status'] == 3 ? "${transactionData['currency']} -${transactionData['refundedAmount'].toStringAsFixed(2)}" : ""),
                      ),
                      Flexible(
                        child: columCon(transactionData['captured'] == false ? "Settled" : "Captured", ""),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  static Widget buildCustomHeader() => Container(
        padding: EdgeInsets.only(bottom: 2 * PdfPageFormat.mm),
        margin: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Powerd by Spent.',
              style: TextStyle(fontSize: 20, color: PdfColors.blue),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Text('Humayun Rahi'),
                Text('Address: 8450 hrh 49'),
                Text('+8801748074624'),
                Text('ad8bb266-48f9-4fd8-9e36-0703bbd22004'),
              ]))
          ],
        ),
      );

  static Container columCon(topTitle, bottomTitle) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(topTitle,
                style: TextStyle(
                    // fontSize: 16
                    )),
          ),
          SizedBox(height: 5),
          Container(
            child: Text(
              bottomTitle,
            ),
          ),
        ],
      ),
    );
  }
}
