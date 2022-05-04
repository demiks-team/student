import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../authentication/helpers/dio/dio_api.dart';
import '../models/payment_model.dart';
import '../models/refund_model.dart';
import '../models/scheduled_payment_model.dart';

class PaymentService {

  Future<List<PaymentModel>> getInvoicePayments(int invoiceId) async {
    var response = await DioApi().dio.get(
        dotenv.env['api'].toString() + "payments/invoice/${invoiceId.toString()}");

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));

      List<PaymentModel> paymentList = decodedList
          .map(
            (dynamic item) => PaymentModel.fromJson(item),
          )
          .toList();

      return paymentList;
    } else {
      throw "Unable to retrieve payments.";
    }
  }


  Future<List<RefundModel>> getInvoiceRefunds(int invoiceId) async {
    var response = await DioApi().dio.get(
        dotenv.env['api'].toString() + "payments/refunds/invoice/${invoiceId.toString()}");

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));

      List<RefundModel> refundList = decodedList
          .map(
            (dynamic item) => RefundModel.fromJson(item),
          )
          .toList();

      return refundList;
    } else {
      throw "Unable to retrieve refunds.";
    }
  }

  Future<List<ScheduledPaymentModel>> getInvoiceScheduledPayments(int invoiceId) async {
    var response = await DioApi().dio.get(
        dotenv.env['api'].toString() + "payments/scheduledPayments/invoice/${invoiceId.toString()}");

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));

      List<ScheduledPaymentModel> scheduledPayments = decodedList
          .map(
            (dynamic item) => ScheduledPaymentModel.fromJson(item),
          )
          .toList();

      return scheduledPayments;
    } else {
      throw "Unable to retrieve scheduled payments.";
    }
  }



}
