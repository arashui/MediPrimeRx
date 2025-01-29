import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../provider/MenuProvider.dart'; // Import MenuProvider
import 'package:path/path.dart'
    as path; // Add this import for working with file paths

class EditMenuItemDialog extends StatefulWidget {
  final int id; // The Hive index of the menu item
  final String name;
  final double price;
  final double? offerPrice;
  final int stock;
  final String category;
  final String? subCategory;
  final String? unitType;
  final String? imageUrl; // Added image URL as a parameter
  final String? description; // Added description as a parameter
  const EditMenuItemDialog({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    this.offerPrice,
    required this.stock,
    required this.category,
    this.subCategory,
    required this.unitType,
    this.imageUrl, // Add image URL as parameter
    this.description, // Add description parameter
  });

  @override
  _EditMenuItemDialogState createState() => _EditMenuItemDialogState();
}

class _EditMenuItemDialogState extends State<EditMenuItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late double price;
  late double? offerPrice;
  late int stock;
  String? category;
  String? subCategory;
  late String unitType;
  File? _imageFile;
  late String description;

  @override
  void initState() {
    print(widget.id);
    super.initState();
    name = widget.name;
    price = widget.price;
    offerPrice = widget.offerPrice;
    stock = widget.stock;
    category = widget.category;
    subCategory = widget.subCategory;
    unitType = widget.unitType!;
    description = widget.description ?? ''; // Initialize description
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

  // Function to update the menu item via MenuProvider
  void _updateMenuItem(MenuItemsProvider menuProvider) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Extract only the file name from the image path
      final imageName =
          _imageFile != null ? path.basename(_imageFile!.path) : null;

      // Update the menu item in the provider
      menuProvider.updateMenuItem(
        widget.id, // Use the id from the dialog parameter
        name,
        price,
        offerPrice,
        stock,
        category!,
        subCategory,
        imageName, // Save the image path
        description, // Pass the description to the provider
      );
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Menu Item",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Name is required'
                      : null,
                  onSaved: (value) => name = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: price.toString(),
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || double.tryParse(value) == null
                          ? 'Enter a valid price'
                          : null,
                  onSaved: (value) => price = double.parse(value!),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: offerPrice?.toString(),
                  decoration:
                      InputDecoration(labelText: 'Offer Price (Optional)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => offerPrice =
                      value?.isEmpty ?? true ? null : double.parse(value!),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: stock.toString(),
                  decoration: InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || int.tryParse(value) == null
                          ? 'Enter a valid stock quantity'
                          : null,
                  onSaved: (value) => stock = int.parse(value!),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: category,
                  decoration: InputDecoration(labelText: 'Category'),
                  items: ['Services', 'Product']
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    category = value;
                    subCategory =
                        null; // Reset subCategory when category changes
                  }),
                ),
                const SizedBox(height: 10),
                if (category == 'Services')
                  DropdownButtonFormField<String>(
                    value: subCategory,
                    decoration: InputDecoration(labelText: 'Subcategory'),
                    items: [
                      'Printing',
                      'Digital Services',
                      'Electrician',
                      'Other Works'
                    ]
                        .map((sub) => DropdownMenuItem(
                              value: sub,
                              child: Text(sub),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => subCategory = value),
                  ),
                if (category == 'Product')
                  DropdownButtonFormField<String>(
                    value: subCategory,
                    decoration: InputDecoration(labelText: 'Subcategory'),
                    items: [
                      'Stationary',
                      'Electronic',
                      'Mobile Accessories',
                      'Other Gadgets'
                    ]
                        .map((sub) => DropdownMenuItem(
                              value: sub,
                              child: Text(sub),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => subCategory = value),
                  ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: description,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Description is required'
                      : null,
                  onSaved: (value) => description = value!,
                ),
                const SizedBox(height: 20),

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
                    child: _widgetImage(_imageFile, widget.imageUrl, context),
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Access MenuProvider using context and update the item
                        final menuProvider = Provider.of<MenuItemsProvider>(
                            context,
                            listen: false);
                        _updateMenuItem(menuProvider);
                      },
                      child: Text("Update"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Directory> getBackupImagePath() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    final home = Directory.current;

    return Directory('${home.path}/dbImage')..createSync(recursive: true);
  } else {
    return getApplicationDocumentsDirectory();
  }
}

Widget _widgetImage(File? imageFile, String? imageUrl, BuildContext context) {
  if (imageFile == null || imageFile.path.isEmpty) {
    // If no local file is provided, check the URL and fetch it
    print(imageFile.toString());
    // If URL is provided, use FutureBuilder to check for the file existence
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return FutureBuilder<Directory>(
        future: getBackupImagePath(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loader while waiting
          } else if (snapshot.hasError) {
            return Icon(Icons.error, color: Colors.red); // Show an error icon
          } else {
            final backupPath = snapshot.data!.path;
            final imagePath = "$backupPath/${imageUrl}";

            if (File(imagePath).existsSync()) {
              return Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              );
            } else {
              return Icon(Icons.warning, color: Colors.red);
            }
          }
        },
      );
    } else {
      // Placeholder if neither local file nor URL is provided
      return Center(
        child: Text("Tap to Update an image"),
      );
    }
  } else {
    print("imageFile == null || imageFile.path.isEmpty");
// If local file is available, display it
    return Image.file(
      imageFile,
      fit: BoxFit.cover,
    );
  }
}
