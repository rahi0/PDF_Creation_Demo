import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_demo/api/pdf_api.dart';
import 'package:pdf_demo/api/pdf_paragraph_api.dart';
import 'package:pdf_demo/main.dart';
import 'package:pdf_demo/widget/button_widget.dart';
import 'package:http/http.dart' as http;

class PdfPage extends StatefulWidget {
  final title;
  PdfPage(this.title);
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {

  bool isLoading = false;
  List allTransactions = [];


  var title1 = "Legend Rahi";
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("${widget.title}"),
          // title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isLoading ? Container(height: 20, width: 20, child: CircularProgressIndicator(),):
                ButtonWidget(
                  text: 'Simple PDF',
                  onClicked: () async {
                    final pdfFile =
                        await PdfApi.generateCenteredText('Sample Text');

                    PdfApi.openFile(pdfFile);
                  },
                ),
                const SizedBox(height: 24),
                ButtonWidget(
                  text: 'Paragraphs PDF',
                  onClicked: () async {
                    getTransactionList();
                    // final pdfFile = await PdfParagraphApi.generate(title);

                    // PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );





//////////////// Transaction list search start//////////////
  Future getTransactionList() async {

    setState(() {
      isLoading = true;
      allTransactions = [];
    });
    final String url = 
         "https://www.uiiapi.co.uk/spent/transaction/list/exported?start_date=2020-09-09&end_date=2021-09-14";
    try {
      print("url " + url);
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZXF1ZXN0Ijp7Il9pZCI6IjYwN2JjMjJmMjBlY2FhMWY2MmViZWI1ZCIsInBhc3N3b3JkIjoiJDJiJDEwJExWMTBvUHBNbGUyMGxEOHJCRldseHU5Z2NvZ2NhNG5iS2xvYS9NY2MxQXpGMllkQWdKeXYyIn0sImlhdCI6MTYyOTcwODA2MX0.c8uH-tuaENR7CD9z4ScW7OYQRTecNaT5oeVbWEWuIKU",
        },
        body: {"rid": "48", "userID": "607bc22f20ecaa1f62ebeb5d"},
      );
      // print("response.body "+response.body);
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
         var dateTransactionsMap = data['body'];
        //  print("Here $dateTransactionsMap");

         for(int i=0; i < dateTransactionsMap.length; i++){
           allTransactions = allTransactions + dateTransactionsMap[i]['list'];
            // allTransactions.addAll( dateTransactionsMap[i]['list']);
            // print("Hereq $allTransactions");
         }

         print("Hereq ${allTransactions.length}");
         final pdfFile = await PdfParagraphApi.generate(allTransactions);
         PdfApi.openFile(pdfFile);

      } else {
        throw HttpException(data['msg']);
      }
    } catch (error) {
      print("Error ${error.toString()}");
      throw error;
    }

    setState(() {
      isLoading = false;
    });
  }
//////////////// Transaction list search end//////////////
}
