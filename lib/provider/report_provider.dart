import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../models/report.dart';

class ReportProvider extends ChangeNotifier{
  static const String _boxName = "reports";

  /// Initialize the Hive box
  static Future<void> initialize() async {
    await Hive.openBox<Report>(_boxName);
  }

  /// Add a new report
  Future<void> addReport(Report report) async {
    final box = Hive.box<Report>(_boxName);
    await box.put(report.reportId, report);
  }

  /// Retrieve a report by ID
  Future<Report?> getReportById(int reportId) async {
    final box = Hive.box<Report>(_boxName);
    return box.get(reportId);
  }

  /// Retrieve all reports
  Future<List<Report>> getAllReports() async {
    final box = Hive.box<Report>(_boxName);
    return box.values.toList();
  }

  /// Update an existing report
  Future<void> updateReport(Report updatedReport) async {
    final box = Hive.box<Report>(_boxName);
    if (box.containsKey(updatedReport.reportId)) {
      await box.put(updatedReport.reportId, updatedReport);
    } else {
      throw Exception("Report with ID ${updatedReport.reportId} not found.");
    }
  }

  /// Delete a report by ID
  Future<void> deleteReport(int reportId) async {
    final box = Hive.box<Report>(_boxName);
    if (box.containsKey(reportId)) {
      await box.delete(reportId);
    } else {
      throw Exception("Report with ID $reportId not found.");
    }
  }

  /// Clear all reports from the box
  Future<void> clearAllReports() async {
    final box = Hive.box<Report>(_boxName);
    await box.clear();
  }
}
