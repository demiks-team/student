import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../authentication/helpers/dio/dio_api.dart';
import '../models/invoice_model.dart';
import '../models/payment_model.dart';
import '../models/refund_model.dart';

class InvoiceService {
  Future<List<InvoiceModel>> getInvoices() async {
    var response =
        await DioApi().dio.get(dotenv.env['api'].toString() + "invoicing/list");

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));
      var invoiceList = decodedList["data"] as List;

      List<InvoiceModel> invoices = invoiceList
          .map(
            (dynamic item) => InvoiceModel.fromJson(item),
          )
          .toList();

      return invoices;
    } else {
      throw "Unable to retrieve invoices.";
    }
  }

  Future<InvoiceModel> getInvoice(int id) async {
    var response = await DioApi().dio.get(
        dotenv.env['api'].toString() + "invoicing/invoice/" + id.toString());

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));

    if (response.statusCode == 200) {
      return InvoiceModel.fromJson(decodedList);
    } else {
      throw Exception('Unable to invoice class.');
    }
  }


}
