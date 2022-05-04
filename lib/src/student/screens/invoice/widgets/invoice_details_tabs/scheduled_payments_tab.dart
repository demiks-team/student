import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/models/scheduled_payment_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/helpers/colors/hex_color.dart';
import '../../../../../shared/services/payment_service.dart';
import '../../../../../shared/theme/colors/demiks_colors.dart';

class ScheduledPaymentsTab extends StatefulWidget {
  const ScheduledPaymentsTab({Key? key, this.invoiceId}) : super(key: key);
  final int? invoiceId;

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
                child: Text(
                    AppLocalizations.of(context)!.noScheduledPaymentsReceived));
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: HexColor.fromHex(DemiksColors.accentColor),
            ),
          );
        }
      },
    );
  }

  ListView _buildScheduledPayments(
      BuildContext context, List<ScheduledPaymentModel>? schedulePayments) {
    return ListView.builder(
      controller: controller,
      itemCount: schedulePayments!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              title: Container(
                  margin: const EdgeInsets.only(left: 8, top: 5),
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
                  margin: const EdgeInsets.only(left: 20, top: 5),
                  child: Column(
                    children: [
                      if (schedulePayments[index].paymentAmount != null)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text("\$" +
                                    schedulePayments[index]
                                        .paymentAmount!
                                        .toStringAsFixed(2)),
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
                                    " : \$" +
                                    (schedulePayments[index].paymentAmount! *
                                            (schedulePayments[index]
                                                    .discountRate! /
                                                100))
                                        .toStringAsFixed(2)),
                              ),
                            ])
                    ],
                  )),
            ));
      },
    );
  }
}
