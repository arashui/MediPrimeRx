import 'package:hive/hive.dart';

part 'report.g.dart'; // Needed for Hive type adapter

@HiveType(typeId: 5) // Unique typeId for this model
class Report {
  @HiveField(0)
  final int reportId; // Unique ID for the report

  @HiveField(1)
  final String title; // Title of the report

  @HiveField(2)
  final String description; // Detailed description of the report

  @HiveField(3)
  final DateTime generatedDate; // Date the report was generated

  @HiveField(4)
  final String generatedBy; // Name or ID of the user who generated the report

  @HiveField(5)
  final String type; // Type of report (e.g., "Sales", "Inventory", "Customer Activity")

  @HiveField(6)
  final Map<String, dynamic> data; // Report data as key-value pairs

  @HiveField(7)
  final String status; // Status of the report (e.g., "Draft", "Completed", "Archived")

  @HiveField(8)
  final String filePath; // Path to the saved report file, if exported

  @HiveField(9)
  final String notes; // Additional notes about the report

  Report({
    required this.reportId,
    required this.title,
    required this.description,
    required this.generatedDate,
    required this.generatedBy,
    required this.type,
    required this.data,
    required this.status,
    required this.filePath,
    required this.notes,
  });

  /// Converts a JSON map into a `Report` instance
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: json['reportId'],
      title: json['title'],
      description: json['description'],
      generatedDate: DateTime.parse(json['generatedDate']),
      generatedBy: json['generatedBy'],
      type: json['type'],
      data: Map<String, dynamic>.from(json['data']),
      status: json['status'],
      filePath: json['filePath'],
      notes: json['notes'],
    );
  }

  /// Converts a `Report` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'title': title,
      'description': description,
      'generatedDate': generatedDate.toIso8601String(),
      'generatedBy': generatedBy,
      'type': type,
      'data': data,
      'status': status,
      'filePath': filePath,
      'notes': notes,
    };
  }
}
