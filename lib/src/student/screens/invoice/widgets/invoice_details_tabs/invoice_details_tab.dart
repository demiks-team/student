import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/helpers/colors/hex_color.dart';
import 'package:student/src/shared/theme/colors/app_colors.dart';

import '../../../../../shared/models/invoice_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/models/payment_model.dart';
import '../../../../../shared/models/refund_model.dart';
import '../../../../../shared/services/invoice_service.dart';

class InvoiceDetailsTab extends StatefulWidget {
  const InvoiceDetailsTab(
      {Key? key,
      required this.invoice,
      required this.payments,
      required this.refunds,
      required this.currencyFormat})
      : super(key: key);

  final InvoiceModel invoice;
  final List<PaymentModel>? payments;
  final List<RefundModel>? refunds;
  final NumberFormat? currencyFormat;

  @override
  State<InvoiceDetailsTab> createState() => _InvoiceDetailsTabState();
}

class _InvoiceDetailsTabState extends State<InvoiceDetailsTab> {
  final ScrollController controller = ScrollController();
    final InvoiceService invoiceService = InvoiceService();

  double get amountDue {
    var invoiceTotal = widget.invoice.total;
    var paymentsTotal = 0.0;
    if (widget.payments != null && widget.payments!.isNotEmpty) {
      paymentsTotal =
          widget.payments!.fold(0, (sum, current) => sum + current.total!);
    }
    return invoiceTotal! - paymentsTotal;
  }

  @override
  Widget build(BuildContext context) {
    var invoice = widget.invoice;
    var currency = widget.currencyFormat;
    return ListView(
      controller: controller,
      children: <Widget>[
        if (invoice.student != null)
          ListTile(
            title: Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(
                              AppLocalizations.of(context)!.student,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(invoice.student!.fullName.toString(),
                                style: const TextStyle(fontSize: 18.0)),
                          ),
                          if (invoice.student!.email != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(invoice.student!.email.toString(),
                                  style: const TextStyle(fontSize: 18.0)),
                            ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 15),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text("# " + invoice.invoiceCode.toString(),
                                style: const TextStyle(fontSize: 18.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                                DateFormat("yMMMMd").format(
                                    DateTime.parse(invoice.createdOn.toString())
                                        .toLocal()),
                                style: const TextStyle(fontSize: 18.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: IconButton(
                              icon: Icon(Icons.picture_as_pdf,
                                  color: HexColor.fromHex(
                                      AppColors.accentColor)),
                              onPressed: () {
                                invoiceService.exportPdf(invoice.id);
                              },
                            ),
                          ),
                        ],
                      )
                    ])),
          ),
        if (invoice.invoiceItems != null)
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  color: HexColor.fromHex(AppColors.backgroundColorAlto),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Text(
                                  AppLocalizations.of(context)!.invoiceItems,
                                  style: const TextStyle(fontSize: 18.0)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Text(
                                  AppLocalizations.of(context)!.subtotal,
                                  style: const TextStyle(fontSize: 18.0)),
                            ),
                          ],
                        ),
                      ]),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                ),
                for (var item in invoice.invoiceItems!)
                  Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(item.course!.name!,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                        item.quantity.toString() +
                                            " x " +
                                            currency!.format(item.unitPrice),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    if (item.discountAmount! > 0)
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                                  .discount +
                                              " : " +
                                              currency
                                                  .format(item.discountAmount),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                          currency.format(item.subtotalPrice!),
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ])),
                      if (item != invoice.invoiceItems!.last)
                        Container(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Divider(
                            thickness: 4,
                            color: HexColor.fromHex(AppColors.primaryColor),
                          ),
                        ),
                    ],
                  ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 15,
                  color: HexColor.fromHex(AppColors.backgroundColorAlto),
                ),
              ],
            ),
          ),
        ListTile(
          title: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(AppLocalizations.of(context)!.subtotal +
                        " : " +
                        currency!.format(invoice.subtotal!)),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(AppLocalizations.of(context)!.discount +
                        " : " +
                        currency.format(invoice.discountAmount)),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(AppLocalizations.of(context)!.taxes +
                        " : " +
                        currency.format(invoice.tax!)),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(AppLocalizations.of(context)!.registrationFee +
                        " : " +
                        currency.format(invoice.registrationFee!)),
                  ),
                ]),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: Divider(
            thickness: 4,
            color: HexColor.fromHex(AppColors.backgroundColorGray),
          ),
        ),
        ListTile(
          title: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      AppLocalizations.of(context)!.total +
                          " : " +
                          currency.format(invoice.total!),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                for (var payment in widget.payments!)
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(AppLocalizations.of(context)!.paymentMadeOn +
                          " " +
                          DateFormat("yMMMMd").format(
                              DateTime.parse(payment.createdOn.toString())
                                  .toLocal()) +
                          "\t \t"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        currency.format(payment.total!),
                      ),
                    ),
                  ]),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: Divider(
            thickness: 4,
            color: HexColor.fromHex(AppColors.backgroundColorGray),
          ),
        ),
        ListTile(
          title: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                if (widget.invoice.isInvoiceRefunded == null ||
                    !widget.invoice.isInvoiceRefunded!)
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        AppLocalizations.of(context)!.amountDue +
                            " : " +
                            currency.format(amountDue),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                if (widget.invoice.isInvoiceRefunded != null &&
                    widget.invoice.isInvoiceRefunded! &&
                    widget.refunds != null)
                  for (var refund in widget.refunds!)
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.refundMadeOn +
                              " " +
                              DateFormat("yMMMMd").format(
                                  DateTime.parse(refund.createdOn.toString())
                                      .toLocal()) +
                              "\t \t",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          currency.format(refund.amount),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
