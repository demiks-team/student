import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import '../../../shared/helpers/colors/hex_color.dart';
import '../../../shared/helpers/colors/material_color.dart';
import '../../../shared/models/currency_model.dart';
import '../../../shared/models/invoice_model.dart';
import '../../../shared/models/payment_model.dart';
import '../../../shared/models/refund_model.dart';
import '../../../shared/services/general_service.dart';
import '../../../shared/services/invoice_service.dart';
import '../../../shared/services/payment_service.dart';
import '../../../shared/theme/colors/demiks_colors.dart';
import 'widgets/invoice_details_tabs/invoice_details_tab.dart';
import 'widgets/invoice_details_tabs/payments_tab.dart';
import 'widgets/invoice_details_tabs/scheduled_payments_tab.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final int invoiceId;

  const InvoiceDetailsScreen({Key? key, required this.invoiceId})
      : super(key: key);

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  InvoiceModel? invoice;
  CurrencyModel? currency = CurrencyModel(
      id: 2,
      currencyCode: 'USD',
      displayFormat: '\${0:0.00}',
      displayOrder: 1,
      name: 'US Dollar',
      sign: '\$');
  NumberFormat? currencyFormat;
  List<PaymentModel>? payments;
  List<RefundModel>? refunds;
  bool completedTasks = false;
  final InvoiceService invoiceService = InvoiceService();
  final PaymentService paymentService = PaymentService();
  final GeneralService generalService = GeneralService();

  @override
  initState() {
    Future.delayed(Duration.zero, () async {
      await initializeTheData();
      completedTasks = true;
    });

    super.initState();
  }

  initializeTheData() async {
    await getInvoice();
    await getPayments();
    await getCurrency(currency!.id);
  }

  getInvoice() async {
    Future<InvoiceModel> futureClass =
        invoiceService.getInvoice(widget.invoiceId);
    await futureClass.then((i) {
      setState(() {
        invoice = i;
        if (i.currencyId != null) {
          currency!.id = i.currencyId!;
        }
      });
    });

    if (invoice!.isInvoiceRefunded != null && invoice!.isInvoiceRefunded!) {
      await getRefunds();
    }
  }

  getCurrency(int id) async {
    Future<CurrencyModel> currencyModel = generalService.getCurrency(id);
    await currencyModel.then((cm) {
      setState(() {
        currency = cm;
        currencyFormat =
            NumberFormat.currency(name: cm.currencyCode, symbol: cm.sign);
      });
    });
  }

  getPayments() async {
    Future<List<PaymentModel>> getPayments =
        paymentService.getInvoicePayments(widget.invoiceId);
    await getPayments.then((p) {
      setState(() {
        payments = p;
      });
    });
  }

  getRefunds() async {
    Future<List<RefundModel>> getRefunds =
        paymentService.getInvoiceRefunds(widget.invoiceId);
    await getRefunds.then((r) {
      setState(() {
        refunds = r;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (completedTasks) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('es', ''),
            Locale('fr', ''),
          ],
          theme: ThemeData(
              primarySwatch: buildMaterialColor(const Color(0xffffffff))),
          home: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("#" + invoice!.invoiceCode.toString()),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: HexColor.fromHex(DemiksColors.accentColor)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  iconTheme: IconThemeData(
                      color: HexColor.fromHex(DemiksColors.accentColor)),
                  bottom: TabBar(
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 35.0),
                    indicatorColor: HexColor.fromHex(DemiksColors.primaryColor),
                    labelColor: Colors.grey,
                    tabs: <Widget>[
                      Tab(text: AppLocalizations.of(context)!.invoice),
                      Tab(text: AppLocalizations.of(context)!.payments),
                      Tab(
                          text:
                              AppLocalizations.of(context)!.scheduledPayments),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    InvoiceDetailsTab(
                      invoice: invoice!,
                      payments: payments,
                      refunds: refunds,
                      currencyFormat: currencyFormat,
                    ),
                    PaymentsTab(
                      payments: payments,
                      currencyFormat: currencyFormat,
                    ),
                    ScheduledPaymentsTab(
                        invoiceId: invoice!.id, currencyFormat: currencyFormat),
                  ],
                ),
              )));
    } else {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          color: HexColor.fromHex(DemiksColors.accentColor),
        ),
      );
    }
  }
}
