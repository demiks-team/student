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
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Text(payments[index]
                                            .paymentMethodId
                                            .toString()
                                            .split('.')
                                            .last)),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Text(DateFormat("yMMMMd").format(
                                            DateTime.parse(payments[index]
                                                    .paymentDate
                                                    .toString())
                                                .toLocal()))),
                                  ]),
                            ]))),
                  );
                })
            : Center(
                child: Text(AppLocalizations.of(context)!.noPaymentsReceived)));
  }
}
