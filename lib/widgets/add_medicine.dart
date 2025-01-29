import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'
as path;

import '../models/product.dart';
import '../provider/drug_provider.dart';
import '../utils/constant/colors.dart'; // Add this import for working with file paths

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _supplierContactController = TextEditingController();
  final TextEditingController _batchNumberController = TextEditingController();
  final TextEditingController _contraindicationsController = TextEditingController();
  final TextEditingController _drugInteractionsController = TextEditingController();
  String category = '';
  String unitType = '';
  DateTime expiryDate = DateTime.now();
  bool prescriptionRequired = true;
  var categoryList = ['Tablet', 'Syrup', 'Injection'];
  var unitTypeList = ['mg', 'ml', 'pcs'];

  // Image picker related variables
  File? _imageFile;


  // Method to clear all fields
  void clearFields() {

    setState(() {
      _nameController.clear();
      _priceController.clear();
      _offerPriceController.clear();
      _stockController.clear();
      _descriptionController.clear();
      _supplierNameController.clear();
      _supplierContactController.clear();
      _batchNumberController.clear();
      _contraindicationsController.clear();
      _drugInteractionsController.clear();
      //Reset unit type to default
       // Reset image selection
    });
    _formKey.currentState?.reset();
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _nameController.dispose();
    _priceController.dispose();
    _offerPriceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }
  Future<Directory> getWritableDirectory() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Use the user's home directory or a custom folder
      final home = Directory.current;
      return Directory('${home.path}/dbImage')..createSync(recursive: true);
    } else {
      // Use standard app document directory for mobile platforms
      return getApplicationDocumentsDirectory();
    }
  }
  // Method to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    try {
      // Pick an image file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        String? filePath = result.files.single.path;

        if (filePath != null) {
          final originalFile = File(filePath);

          // Check if file exists
          if (await originalFile.exists()) {
            // Get writable directory based on platform
            final directory = await getWritableDirectory();
            final fileName = result.files.single.name;

            // Construct the target path
            final targetFilePath = '${directory.path}/$fileName';

            // Copy the file to the target directory
            final copiedFile = await originalFile.copy(targetFilePath);

            // Update the state with the new file path
            setState(() {
              _imageFile = copiedFile;
            });
            print('File copied to: $targetFilePath');
          } else {
            throw Exception('File not found at path: $filePath');
          }
        } else {
          throw Exception('Selected file path is null.');
        }
      } else {
        print('No file selected.');
      }
    } catch (e) {
      print('An error occurred while picking the file: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: secondaryColor,
        shadowColor: bgColor,

      title: Text('Add Items/Services', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker Section
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imageFile == null
                      ? Center(child: Text("Tap to select an image"))
                      : Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildTextFormField('Item/Services Name', Icons.barcode_reader, _nameController),
              Row(
                children: [
                  Expanded(child: _buildNumberFormField('Price', Icons.price_change_outlined, _priceController)),
                  Expanded(child: _buildNumberFormField('Offer', Icons.local_offer, _offerPriceController)),
                ],
              ),
              _buildNumberFormField('Stock', Icons.remove_shopping_cart, _stockController),
              _buildDescriptionFormField('Description', _descriptionController),

              // Category Selection
              _buildDropdownField('Category', categoryList, (val) => setState(() => category = val!)),

              // Unit Type Selection
              _buildDropdownField('Unit Type', unitTypeList, (val) => setState(() => unitType = val!)),

              // Prescription Required
              Row(
                children: [
                  Text('Prescription Required:'),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: prescriptionRequired,
                        onChanged: (val) => setState(() => prescriptionRequired = val!),
                      ),
                      Text('Yes'),
                      Radio<bool>(
                        value: false,
                        groupValue: prescriptionRequired,
                        onChanged: (val) => setState(() => prescriptionRequired = val!),
                      ),
                      Text('No'),
                    ],
                  ),
                ],
              ),

              // Expiry Date Picker
              _buildDatePickerField('Expiry Date', expiryDate, (date) => setState(() => expiryDate = date)),

              // Supplier Details
              _buildTextFormField('Supplier Name', Icons.business, _supplierNameController),
              _buildTextFormField('Supplier Contact', Icons.phone, _supplierContactController),

              // Batch Number
              _buildTextFormField('Batch Number', Icons.confirmation_number, _batchNumberController),

              // Contraindications
              _buildTextFormField('Contraindications', Icons.warning_amber_outlined, _contraindicationsController),

              // Drug Interactions
              _buildTextFormField('Drug Interactions', Icons.science_outlined, _drugInteractionsController),



            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final imageName =
            _imageFile != null ? path.basename(_imageFile!.path) : null;

            if (_formKey.currentState!.validate()) {
              final randomId = Random().nextInt(100000);  // Random ID between 0 and 999999
              final newMedicineItem = PharmacyDrug(
                id: randomId,
                name: _nameController.text,
                price: double.tryParse(_priceController.text) ?? 0.0,
                offerPrice: double.tryParse(_offerPriceController.text) ?? 0.0,
                stock: int.tryParse(_stockController.text) ?? 0,
                category: category,
                subcategory: "",
                unitType: unitType,
                form: _descriptionController.text,
                imageUrl: imageName.toString(), // Handle Image Upload
                genericName: '',
                manufacturer: '',
                barcode: '',
                expiryDate: expiryDate,
                batchNumber: _batchNumberController.text,
                unitSize: 1.1,
                storageConditions: '',
                prescriptionRequired: prescriptionRequired,
                dateAdded: DateTime.now(),
                supplierName: _supplierNameController.text,
                supplierContact: _supplierContactController.text,
                mrp: 0.0,
                gst: 18.00,
                reorderLevel: 1,
                contraindications: _contraindicationsController.text,
                drugInteractions: _drugInteractionsController.text,
                medicineComposition: '',
              );

              // Get the MenuProvider from the context
              final medicineProvider = Provider.of<PharmacyDrugProvider>(context, listen: false);
              medicineProvider.addMenuItem(newMedicineItem);
              clearFields(); // Clear fields without closing the dialog
              // Get.back();
            }
          },
          child: Text('Add Item'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  // Helper functions to build form fields
  Widget _buildTextFormField(String label,IconData? icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon, // Icon to indicate input field purpose
            color: primaryColor,
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[600], // Subtle color for the label
            fontWeight: FontWeight.w500,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto, // Animates label
          filled: true,
          fillColor: secondary2Color, // Light background color
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Rounded edges
            borderSide: BorderSide.none, // Remove border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: primaryColor, // Focused border color
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.red, // Error border color
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.red, // Focused error border color
              width: 2,
            ),
          ),
        ),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
  Widget _buildDescriptionFormField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDatePickerField(String label, DateTime selectedDate, ValueChanged<DateTime> onDateSelected) {
    return ListTile(
      title: Text("$label: ${selectedDate.toLocal()}".split(' ')[0]),
      trailing: Icon(Icons.calendar_today),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          onDateSelected(pickedDate);
        }
      },
    );
  }
  Widget _buildNumberFormField(String label,IconData? icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 250, // Set the width here
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[600], // Subtle color for the label
              fontWeight: FontWeight.w500,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto, // Animates label
            filled: true,
            fillColor: secondary2Color, // Light background color
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // Rounded edges
              borderSide: BorderSide.none, // Remove border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: primaryColor, // Focused border color
                width: 2,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.red, // Error border color
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.red, // Focused error border color
                width: 2,
              ),
            ),
            prefixIcon: Icon(
              icon, // Icon to indicate input field purpose
              color: primaryColor,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            if (!RegExp(r'^\d+$').hasMatch(value)) {
              return 'Please enter only numbers';
            }
            return null;
          },
        ),
      ),
    );
  }
}
