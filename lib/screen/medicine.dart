import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/drug_provider.dart';
import '../utils/constant/colors.dart';
import '../utils/responsive.dart';
import '../widgets/add_medicine.dart';

class Medicine extends StatefulWidget {
  const Medicine({super.key});

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final medicineProvider = Provider.of<PharmacyDrugProvider>(context, listen: false);
      medicineProvider.pharmacyDrugs;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Services/Items",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ElevatedButton.icon(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AddMedicine(),
                          ).then((_) => setState(() {}));
                        },
                        icon: Icon(Icons.add),
                        label: Text("Add New"),
                      ),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search Services/Items",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: secondary2Color,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  Consumer<PharmacyDrugProvider>(
                    builder: (context, menuProvider, _) {
                      final medicineItems = menuProvider.pharmacyDrugs.where((item) {
                        final itemName = item.name.toLowerCase();
                        return itemName.contains(searchQuery.toLowerCase());
                      }).toList();

                      if (medicineItems.isEmpty) {
                        return Center(child: Text("No Services/Items available"));
                      }
return Container();
                      // return SizedBox(
                      //   width: double.infinity,
                      //   child: DataTable(
                      //     columnSpacing: defaultPadding,
                      //     columns: [
                      //       DataColumn(label: Text("Name")),
                      //       DataColumn(label: Text("Price/Offer")),
                      //       if (!Responsive.isMobile(context))
                      //         DataColumn(label: Text("Stock")),
                      //       DataColumn(label: Text("Category")),
                      //       if (!Responsive.isMobile(context))
                      //         DataColumn(label: Text("Subcategory")),
                      //       DataColumn(label: Text("Actions")),
                      //     ],
                      //     rows: List.generate(
                      //       medicineItems.length,
                      //           (index) =>
                      //           menuItemDataRow(medicineItems[index], index, menuProvider, context),
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // DataRow menuItemDataRow(
  //     MenuItem menuItem, int index, MenuItemsProvider menuProvider, BuildContext context) {
  //
  //   return DataRow(
  //     cells: [
  //       if (!Responsive.isMobile(context))
  //         DataCell(
  //           Row(
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   showDialog(
  //                     context: context,
  //                     builder: (_) => Dialog(
  //                       child: LayoutBuilder(
  //                         builder: (context, constraints) {
  //                           double width = constraints.maxWidth;
  //                           double imageSize = width * 0.25;
  //                           double textSize = width * 0.04;
  //
  //                           return Column(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               FutureBuilder<Directory>(
  //                                 future: getBackupImagePath(),
  //                                 builder: (context, snapshot) {
  //                                   if (snapshot.connectionState == ConnectionState.waiting) {
  //                                     return CircularProgressIndicator(); // Show a loader while waiting
  //                                   } else if (snapshot.hasError) {
  //                                     return Icon(Icons.error, color: Colors.red); // Show an error icon
  //                                   } else {
  //                                     final backupPath = snapshot.data!.path;
  //                                     final imagePath = "$backupPath/${menuItem.imageUrl}";
  //                                     print(imagePath);
  //                                     if (File(imagePath).existsSync()) {
  //                                       return Image.file(
  //                                         File(imagePath),
  //                                         fit: BoxFit.cover,
  //                                         height: imageSize,
  //                                         width: imageSize,
  //                                       );
  //                                     } else {
  //                                       return Icon(Icons.warning, size: imageSize, color: Colors.red);
  //                                     }
  //                                   }
  //                                 },
  //                               ),
  //
  //                               // // Fallback if no image URL is provided
  //
  //                               SizedBox(height: 8),
  //                               Text(
  //                                 menuItem.itemName,
  //                                 style: TextStyle(
  //                                   fontSize: textSize,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(20),
  //                   child: CircleAvatar(
  //                     radius: 20,
  //                     child: FutureBuilder<Directory>(
  //                       future: getBackupImagePath(),
  //                       builder: (context, snapshot) {
  //                         if (snapshot.connectionState == ConnectionState.waiting) {
  //                           return CircularProgressIndicator(); // Show a loader while waiting
  //                         } else if (snapshot.hasError) {
  //                           return Icon(Icons.error, color: Colors.red); // Show an error icon
  //                         } else {
  //                           final backupPath = snapshot.data!.path;
  //                           final imagePath = "$backupPath/${menuItem.imageUrl}";
  //
  //                           if (File(imagePath).existsSync()) {
  //                             return Image.file(
  //                               File(imagePath),
  //                               fit: BoxFit.cover,
  //
  //                             );
  //                           } else {
  //                             return Icon(Icons.warning, color: Colors.red);
  //                           }
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 8),
  //               Expanded(
  //                 child: Text(
  //                   menuItem.itemName,
  //                   style: TextStyle(fontSize: 14),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       if (!Responsive.isDesktop(context))
  //         DataCell(
  //           Text(
  //             menuItem.itemName,
  //             style: TextStyle(fontSize: 14),
  //           ),
  //         ),
  //       DataCell(
  //         Responsive.isMobile(context)
  //             ? Column(
  //           children: [
  //             if (menuItem.offerPrice != null && menuItem.offerPrice > 0)
  //               Text(
  //                 '\$${menuItem.price}',
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   color: Colors.grey,
  //                   decoration: TextDecoration.lineThrough,
  //                 ),
  //               ),
  //             if (menuItem.offerPrice != null && menuItem.offerPrice > 0)
  //               Text(
  //                 '\$${menuItem.offerPrice}',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.green,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             if (menuItem.offerPrice == null || menuItem.offerPrice <= 0)
  //               Text(
  //                 '\$${menuItem.price}',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //           ],
  //         )
  //             : Row(
  //           children: [
  //             if (menuItem.offerPrice != null && menuItem.offerPrice > 0)
  //               Text(
  //                 '\$${menuItem.price}',
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   color: Colors.grey,
  //                   decoration: TextDecoration.lineThrough,
  //                 ),
  //               ),
  //             SizedBox(width: 5),
  //             if (menuItem.offerPrice != null && menuItem.offerPrice > 0)
  //               Text(
  //                 '\$${menuItem.offerPrice}',
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   color: Colors.green,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             if (menuItem.offerPrice == null || menuItem.offerPrice <= 0)
  //               Text(
  //                 '\$${menuItem.price}',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ),
  //       if (!Responsive.isMobile(context))
  //         DataCell(
  //           Container(
  //             width: 60,
  //             height: 30,
  //             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //             decoration: BoxDecoration(
  //               color: menuItem.stock >= 10 ? Colors.green : Colors.red,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Center(
  //               child: Text(
  //                 menuItem.stock.toString(),
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 14,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       DataCell(
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //           decoration: BoxDecoration(
  //             color: menuItem.category == 'Services' ? Colors.green : Colors.red,
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 menuItem.category == 'Services' ? Icons.dashboard_customize_outlined : Icons.production_quantity_limits,
  //                 size: 14,
  //                 color: Colors.white,
  //               ),
  //               SizedBox(width: 5),
  //               Text(
  //                 menuItem.category == 'Services' ? 'Services' : 'Product',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       if (!Responsive.isMobile(context))
  //         DataCell(Text(menuItem.subCategory ?? '-')),
  //       DataCell(
  //         Row(
  //           children: [
  //             IconButton(
  //               icon: Icon(Icons.edit, color: Colors.white),
  //               onPressed: () {
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) => EditMenuItemDialog(
  //                     id: menuItem.id,
  //                     name: menuItem.itemName,
  //                     price: menuItem.price,
  //                     offerPrice: menuItem.offerPrice,
  //                     stock: menuItem.stock,
  //                     category: menuItem.category,
  //                     subCategory: menuItem.subCategory,
  //                     unitType: menuItem.unitType,
  //                     imageUrl: menuItem.imageUrl,
  //                     description: menuItem.description,
  //                   ),
  //                 ).then((_) => setState(() {}));
  //               },
  //             ),
  //             IconButton(
  //               icon: Icon(Icons.delete, color: Colors.red),
  //               onPressed: () {
  //                 menuProvider.deleteMenuItem(menuItem.id);
  //                 setState(() {});
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}