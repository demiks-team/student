import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/models/scheduled_payment_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/services/payment_service.dart';
import '../../../../../shared/theme/colors/app_colors.dart';

class ScheduledPaymentsTab extends StatefulWidget {
  const ScheduledPaymentsTab({Key? key, this.invoiceId, this.currencyFormat})
      : super(key: key);
  final int? invoiceId;
  final NumberFormat? currencyFormat;

  @override
  State<ScheduledPaymentsTab> createState() => _ScheduledPaymentsTabState();
}

class _ScheduledPaymentsTabState extends State<ScheduledPaymentsTab>
    with AutomaticKeepAliveClientMixin {
  Future<List<ScheduledPaymentModel>>? scheduledPayments;
  final PaymentService paymentService = PaymentService();
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    scheduledPayments = getScheduledPaymentsList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Future<List<ScheduledPaymentModel>> getScheduledPaymentsList() async {
    return paymentService.getInvoiceScheduledPayments(widget.invoiceId!);
  }

  @override
  bool get wantKeepAlive => true;

  FutureBuilder<List<ScheduledPaymentModel>> _buildBody(BuildContext context) {
    return FutureBuilder<List<ScheduledPaymentModel>>(
      future: scheduledPayments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<ScheduledPaymentModel>? scheduledPaymentList =
              snapshot.data;
          if (scheduledPaymentList!.isNotEmpty) {
            return _buildScheduledPayments(context, scheduledPaymentList);
          } else {
            return Center(
                child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(AppLocalizations.of(context)!
                        .noScheduledPaymentsReceived)));
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: HexColor.fromHex(AppColors.accentColor),
            ),
          );
        }
      },
    );
  }

  ListView _buildScheduledPayments(
      BuildContext context, List<ScheduledPaymentModel>? schedulePayments) {
    var currency = widget.currencyFormat;
    return ListView.builder(
      controller: controller,
      itemCount: schedulePayments!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              title: Container(
                  margin: const EdgeInsets.only(
                      left: 15, top: 25, bottom: 15, right: 15),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 1),
                              child: Text(
                                DateFormat("yMMMMd").format(DateTime.parse(
                                        schedulePayments[index]
                                            .scheduledDate
                                            .toString())
                                    .toLocal()),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ]),
                  ])),
              subtitle: Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Column(
                    children: [
                      if (schedulePayments[index].paymentAmount != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(currency!.format(
                                    schedulePayments[index].paymentAmount!)),
                              ),
                            ]),
                      if (schedulePayments[index].discountRate != null &&
                          schedulePayments[index].discountRate! > 0)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(AppLocalizations.of(context)!
                                        .discountAmount +
                                    " : " +
                                    (currency!.format(schedulePayments[index]
                                            .paymentAmount! *
                                        (schedulePayments[index].discountRate! /
                                            100)))),
                              ),
                            ])
                    ],
                  )),
            ));
      },
    );
  }
}
