import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'models/customer.dart';
import 'models/invoice.dart';
import 'models/order_drug.dart';
import 'models/pharmacy.dart';
import 'models/product.dart';
import 'models/report.dart';
import 'models/user_activity.dart';
import 'provider/customer_provider.dart';
import 'provider/drug_provider.dart';
import 'provider/invoice_provider.dart';
import 'provider/order_drug_provider.dart';
import 'provider/pharmacy_provider.dart';
import 'provider/report_provider.dart';
import 'provider/user_activity_provider.dart';
import 'utils/constant/colors.dart';
import 'widgets/side_menu.dart';

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
    } else if (Platform.isWindows || Platform.isMacOS) {
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
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(PharmacyDrugAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(ReportAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(UserActivityAdapter());
    }
    // Open the boxes after registering the adapters
    await Hive.openBox<Customer>('customer');
    await Hive.openBox<Invoice>('invoice');
    await Hive.openBox<OrderDrug>('order_drug');
    await Hive.openBox<Pharmacy>('pharmacy');
    await Hive.openBox<PharmacyDrug>('product');
    await Hive.openBox<Report>('report');
    await Hive.openBox<UserActivity>('user_activity');

    debugPrint('Box opened successfully');
  } catch (e) {
    debugPrint("Error initializing Hive: $e");
  }

  runApp(const MediPrimeRx());
}

class MediPrimeRx extends StatelessWidget {
  const MediPrimeRx({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerProvider>(create: (_) => CustomerProvider()),
        ChangeNotifierProvider<PharmacyDrugProvider>(create: (_) => PharmacyDrugProvider()..pharmacyDrugs),
        ChangeNotifierProvider<InvoiceProvider>(create: (_) => InvoiceProvider()),
        ChangeNotifierProvider<OrderDrugProvider>(create: (_) => OrderDrugProvider()),
        ChangeNotifierProvider<PharmacyProvider>(create: (_) => PharmacyProvider()),
        ChangeNotifierProvider<ReportProvider>(create: (_) => ReportProvider()..getAllReports()),
        ChangeNotifierProvider<UserActivityProvider>(create: (_) => UserActivityProvider()),
      ],
      child: GetMaterialApp(
        title: 'MediPrimeRx',
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

  }}

