import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/helpers/colors/hex_color.dart';
import 'package:student/src/shared/theme/colors/demiks_colors.dart';

import '../../../../../shared/models/invoice_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../shared/models/payment_model.dart';
import '../../../../../shared/models/refund_model.dart';

class InvoiceDetailsTab extends StatefulWidget {
  const InvoiceDetailsTab(
      {Key? key,
      required this.invoice,
      required this.payments,
      required this.refunds})
      : super(key: key);

  final InvoiceModel invoice;
  final List<PaymentModel>? payments;
  final List<RefundModel>? refunds;

  @override
  State<InvoiceDetailsTab> createState() => _InvoiceDetailsTabState();
}

class _InvoiceDetailsTabState extends State<InvoiceDetailsTab> {
  final ScrollController controller = ScrollController();
  final formatCurrency = NumberFormat.currency(
    name: "Canadian Dollar",
    symbol: "CAD",
  );

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
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.currency(name: 'USD',symbol : '\$');
    // format.currencyName = "us";
    print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    print("CURRENCY NAME ${format.currencyName}");
    print(format.format(52.345));
    // final oCcy = NumberFormat.currency(
    //     locale: 'eu',
    //     customPattern: '# \u00a4',
    //     symbol: '\$',
    //     decimalDigits: 2,
    //     name: 'CAD');
    //     oCcy.currencyName = "USD";
//  123.94 $
    // print(oCcy.format(123.9455));

// final oCcy = NumberFormat.currency(
//       locale: 'eu',
//       customPattern: '#,### \u00a4',
//       symbol: 'FCFA',
//       decimalDigits: 2);

// print(oCcy.format(12345));

    var invoice = widget.invoice;
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
                  color: HexColor.fromHex(DemiksColors.backgroundColorAlto),
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
                                            item.unitPrice.toString(),
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
                                              item.discountAmount.toString(),
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
                                          "\$" + item.subtotalPrice!.toString(),
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
                            color: HexColor.fromHex(DemiksColors.primaryColor),
                          ),
                        ),
                    ],
                  ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 15,
                  color: HexColor.fromHex(DemiksColors.backgroundColorAlto),
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
                        invoice.subtotal!.toStringAsFixed(2)),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(AppLocalizations.of(context)!.discount +
                        " : " +
                        invoice.discountAmount!.toStringAsFixed(2)),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(AppLocalizations.of(context)!.taxes +
                        " : " +
                        invoice.tax!.toStringAsFixed(2)),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(AppLocalizations.of(context)!.registrationFee +
                        " : " +
                        invoice.registrationFee!.toStringAsFixed(2)),
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
            color: HexColor.fromHex(DemiksColors.backgroundColorGray),
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
                          invoice.total!.toStringAsFixed(2),
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
                        payment.total!.toStringAsFixed(2),
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
            color: HexColor.fromHex(DemiksColors.backgroundColorGray),
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
                            amountDue.toStringAsFixed(2),
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
                          refund.amount!.toStringAsFixed(2),
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
