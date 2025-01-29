import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:medi_prime_rx/provider/customer_provider.dart';
import 'package:medi_prime_rx/provider/drug_provider.dart';
import 'package:medi_prime_rx/provider/invoice_provider.dart';
import 'package:medi_prime_rx/provider/order_drug_provider.dart';
import 'package:medi_prime_rx/provider/pharmacy_provider.dart';
import 'package:medi_prime_rx/provider/report_provider.dart';
import 'package:medi_prime_rx/provider/user_activity_provider.dart';
import 'package:medi_prime_rx/widgets/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import 'Screen/user_activity_screen.dart';
import 'models/customer.dart';
import 'models/invoice.dart';
import 'models/order_drug.dart';
import 'models/pharmacy.dart';
import 'models/product.dart';
import 'models/report.dart';
import 'models/user_activity.dart';
import 'utils/constant/colors.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

  try {
    // Define the path for Hive storage
    var path = '';
    if (Platform.isAndroid || Platform.isIOS) {
      // Use path_provider for mobile platforms
      final directory = await getApplicationDocumentsDirectory();
      path = '${directory.path}/mediprimerx';
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Use the current directory for desktop platforms
      path = '${Directory.current.path}/mediprimerx';
    }

    // Create the directory if it doesn't exist
    await Directory(path).create(recursive: true);
    Hive.init(path);

    // Register adapters before opening boxes
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CustomerAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(InvoiceAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(OrderDrugAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(PharmacyAdapter());
    }if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(PharmacyDrugAdapter());
    }if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(ReportAdapter());
    }if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(UserActivityAdapter());
    }
    // Open the boxes after registering the adapters
    await Hive.openBox<Customer>('invoice_items');
    await Hive.openBox<Invoice>('invoices');
    await Hive.openBox<OrderDrug>('menu_items');
    await Hive.openBox<Pharmacy>('invoice_items');
    await Hive.openBox<PharmacyDrug>('invoices');
    await Hive.openBox<Report>('menu_items');
    await Hive.openBox<UserActivity>('business_Settings');

  } catch (e) {
    if (kDebugMode) {
      print("Error initializing Hive: $e");
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerProvider>(create: (_) => CustomerProvider()..customers),
        ChangeNotifierProvider<PharmacyDrugProvider>(create: (_) => PharmacyDrugProvider()..pharmacyDrugs),
        ChangeNotifierProvider<InvoiceProvider>(create: (_) => InvoiceProvider()..invoices),
        ChangeNotifierProvider<OrderDrugProvider>(create: (_) => OrderDrugProvider()..orders),
        ChangeNotifierProvider<PharmacyProvider>(create: (_) => PharmacyProvider()),
        ChangeNotifierProvider<ReportProvider>(create: (_) => ReportProvider()),
        ChangeNotifierProvider<UserActivityProvider>(create: (_) => UserActivityProvider()..getAllActivities),


      ],
      child: GetMaterialApp(
        title: 'NeoServeX       ',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: const SideMenu(),
      ),
    );

  }


}