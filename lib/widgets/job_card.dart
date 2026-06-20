import 'package:flutter/material.dart';
import '../models/job.dart';
import '../app_colors.dart';

/// Grid içinde gösterilen tek bir ilan kartı (tekrar kullanılabilir).
class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobCard({super.key, required this.job, required this.onTap});

  static IconData iconFor(String category) {
    switch (category) {
      case 'code':
        return Icons.code;
      case 'design':
        return Icons.brush_outlined;
      case 'mobile':
        return Icons.phone_android;
      case 'devops':
        return Icons.cloud_outlined;
      case 'data':
        return Icons.bar_chart;
      case 'content':
        return Icons.edit_outlined;
      default:
        return Icons.work_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.chipBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(iconFor(job.category), color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(
              job.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${job.company} · ${job.location}',
              style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.chipBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                job.salary,
                style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
