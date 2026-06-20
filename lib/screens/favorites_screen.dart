import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../models/job.dart';
import '../services/job_service.dart';
import '../state/app_state.dart';
import '../widgets/job_card.dart';

/// Kaydedilenler ekranı: Favoriler ve Başvurular sekmeleri.
/// İlanları kendi yükler, AppState'teki id'lere göre süzer.
class FavoritesScreen extends StatefulWidget {
  final int initialTab; // 0 = Favoriler, 1 = Başvurular
  const FavoritesScreen({super.key, this.initialTab = 0});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final JobService _service = JobService();
  List<Job> _allJobs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _service.loadJobs().then((jobs) {
      setState(() {
        _allJobs = jobs;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialTab,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          title: const Text('Kaydedilenler'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Favoriler'),
              Tab(text: 'Başvurular'),
            ],
          ),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _list(AppState.instance.favorites, 'Henüz favori ilan yok'),
                  _list(AppState.instance.applied, 'Henüz başvuru yok'),
                ],
              ),
      ),
    );
  }

  Widget _list(ValueNotifier<Set<int>> notifier, String emptyText) {
    return ValueListenableBuilder<Set<int>>(
      valueListenable: notifier,
      builder: (context, ids, _) {
        final jobs = _allJobs.where((j) => ids.contains(j.id)).toList();
        if (jobs.isEmpty) {
          return Center(
            child: Text(emptyText,
                style: const TextStyle(color: AppColors.textMuted)),
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: jobs.map((job) => _row(context, job)).toList(),
        );
      },
    );
  }

  Widget _row(BuildContext context, Job job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.chipBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(JobCard.iconFor(job.category), color: AppColors.primary),
        ),
        title:
            Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${job.company} · ${job.location} · ${job.salary}',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: () => Navigator.pushNamed(context, '/detail', arguments: job),
      ),
    );
  }
}
