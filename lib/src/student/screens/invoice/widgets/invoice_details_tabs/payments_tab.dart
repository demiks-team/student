import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/models/payment_model.dart';

class PaymentsTab extends StatefulWidget {
  const PaymentsTab(
      {Key? key, required this.payments, required this.currencyFormat})
      : super(key: key);
  final List<PaymentModel>? payments;
  final NumberFormat? currencyFormat;

  @override
  State<PaymentsTab> createState() => _PaymentsTabState();
}

class _PaymentsTabState extends State<PaymentsTab>
    with AutomaticKeepAliveClientMixin {
  final ScrollController controller = ScrollController();
  @override
  bool get wantKeepAlive => true;

  String checkTypeOfPayment(String typeOfPayment) {
    if (typeOfPayment == 'online') {
      return AppLocalizations.of(context)!.online;
    } else if (typeOfPayment == 'cash') {
      return AppLocalizations.of(context)!.cash;
    } else if (typeOfPayment == 'card') {
      return AppLocalizations.of(context)!.card;
    } else if (typeOfPayment == 'processors') {
      return AppLocalizations.of(context)!.processors;
    } else if (typeOfPayment == 'check') {
      return AppLocalizations.of(context)!.check;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    var payments = widget.payments;
    var currency = widget.currencyFormat;
    super.build(context);
    return Scaffold(
        body: payments != null && payments.isNotEmpty
            ? ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(8),
                itemCount: payments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                        title: Container(
                            margin: const EdgeInsets.only(
                                left: 15, top: 25, bottom: 15, right: 15),
                            child: Text(
                              currency!.format(payments[index].total),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                        subtitle: Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Text(checkTypeOfPayment(
                                          payments[index]
                                              .paymentMethodId
                                              .toString()
                                              .split('.')
                                              .last))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Text(DateFormat("yMMMMd").format(
                                          DateTime.parse(payments[index]
                                                  .paymentDate
                                                  .toString())
                                              .toLocal()))),
                                ]))),
                  );
                })
            : Center(
                child: Text(AppLocalizations.of(context)!.noPaymentsReceived)));
  }
}
