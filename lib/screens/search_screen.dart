import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../models/job.dart';
import '../widgets/job_card.dart';

/// İş Ara ekranı: arama çubuğu + filtreler (çalışma şekli, konum).
class SearchScreen extends StatefulWidget {
  final List<Job> jobs;
  const SearchScreen({super.key, required this.jobs});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  final Set<String> _selectedTypes = {};
  final Set<String> _selectedLocations = {};

  List<String> get _allTypes =>
      widget.jobs.map((j) => j.type).toSet().toList();
  List<String> get _allLocations =>
      widget.jobs.map((j) => j.location).toSet().toList();

  List<Job> get _results {
    return widget.jobs.where((j) {
      final q = _query.toLowerCase();
      final matchesQuery = q.isEmpty ||
          j.title.toLowerCase().contains(q) ||
          j.company.toLowerCase().contains(q);
      final matchesType =
          _selectedTypes.isEmpty || _selectedTypes.contains(j.type);
      final matchesLocation = _selectedLocations.isEmpty ||
          _selectedLocations.contains(j.location);
      return matchesQuery && matchesType && matchesLocation;
    }).toList();
  }

  bool get _hasActiveFilters =>
      _selectedTypes.isNotEmpty ||
      _selectedLocations.isNotEmpty ||
      _query.isNotEmpty;

  void _clearFilters() {
    setState(() {
      _selectedTypes.clear();
      _selectedLocations.clear();
      _query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('İş Ara',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Pozisyon veya şirket ara...',
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textMuted),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _filterGroup('Çalışma Şekli', _allTypes, _selectedTypes),
              const SizedBox(height: 16),
              _filterGroup('Konum', _allLocations, _selectedLocations),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${results.length} ilan bulundu',
                      style: const TextStyle(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600)),
                  if (_hasActiveFilters)
                    TextButton.icon(
                      onPressed: _clearFilters,
                      icon: const Icon(Icons.clear, size: 16),
                      label: const Text('Temizle'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (results.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text('Kriterlere uygun ilan bulunamadı',
                        style: TextStyle(color: AppColors.textMuted)),
                  ),
                )
              else
                ...results.map((job) => _resultRow(context, job)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filterGroup(
      String title, List<String> options, Set<String> selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: options.map((opt) {
            final isSelected = selected.contains(opt);
            return FilterChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (val) {
                setState(() {
                  if (val) {
                    selected.add(opt);
                  } else {
                    selected.remove(opt);
                  }
                });
              },
              selectedColor: AppColors.chipBg,
              checkmarkColor: AppColors.primaryDark,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _resultRow(BuildContext context, Job job) {
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
        title: Text(job.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${job.company} · ${job.location} · ${job.salary}',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: () => Navigator.pushNamed(context, '/detail', arguments: job),
      ),
    );
  }
}
