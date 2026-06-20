import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/job.dart';

/// Veri katmanı: ilanları yerel JSON dosyasından (simülasyon) yükler.
class JobService {
  Future<List<Job>> loadJobs() async {
    final String response = await rootBundle.loadString('assets/jobs.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;
    return data
        .map((item) => Job.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
