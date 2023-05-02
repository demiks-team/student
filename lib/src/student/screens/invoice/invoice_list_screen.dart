import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/src/shared/no_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/helpers/colors/hex_color.dart';
import '../../../shared/models/invoice_model.dart';
import '../../../shared/services/invoice_service.dart';
import '../../../shared/theme/colors/app_colors.dart';
import 'invoice_details_screen.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.invoices),
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          color: HexColor.fromHex(AppColors.accentColor),
          backgroundColor: Theme.of(context).primaryColor,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            setState(() {});
          },
          child: _buildBody(context),
        ));
  }

  FutureBuilder<List<InvoiceModel>> _buildBody(BuildContext context) {
    final InvoiceService invoiceService = InvoiceService();
    return FutureBuilder<List<InvoiceModel>>(
      future: invoiceService.getInvoices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<InvoiceModel>? classes = snapshot.data;
          if (classes != null) {
            if (classes.isNotEmpty) {
              return _buildInvoices(context, classes);
            } else {
              return RefreshIndicator(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(AppLocalizations.of(context)!.noInvoice),
                    ),
                    ListView()
                  ],
                ),
                onRefresh: () async {
                  setState(() {});
                },
              );
            }
          } else {
            return RefreshIndicator(
              child: Stack(
                children: <Widget>[
                  const Center(
                    child: NoData(),
                  ),
                  ListView()
                ],
              ),
              onRefresh: () async {
                setState(() {});
              },
            );
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

  ListView _buildInvoices(BuildContext context, List<InvoiceModel>? invoices) {
    return ListView.builder(
      itemCount: invoices!.length,
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 25),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => InvoiceDetailsScreen(
                            invoiceId: invoices[index].id)));
              },
              title: Container(
                  margin: const EdgeInsets.only(
                      left: 15, top: 25, bottom: 15, right: 15),
                  child: Text(
                    invoices[index].invoiceCode.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              subtitle: Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("\$" +
                            invoices[index].subtotal!.toStringAsFixed(2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(DateFormat("yMMMMd").format(
                            DateTime.parse(invoices[index].createdOn.toString())
                                .toLocal())),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Icon(Icons.receipt, size: 30),
                        ],
                      ),
                    ],
                  )),
            ));
      },
    );
  }
}
