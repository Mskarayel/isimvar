import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../models/job.dart';
import '../services/job_service.dart';
import '../widgets/job_card.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

/// Ana kabuk: alt menü ile 4 ekran arasında geçiş yapar.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final JobService _service = JobService();
  List<Job> _allJobs = [];
  bool _loading = true;
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    final jobs = await _service.loadJobs();
    setState(() {
      _allJobs = jobs;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _buildBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: 'İşler'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'İş Ara'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Ayarlar'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_navIndex) {
      case 1:
        return SearchScreen(jobs: _allJobs);
      case 2:
        return const ProfileScreen();
      case 3:
        return const SettingsScreen();
      default:
        return _buildFeaturedView();
    }
  }

  Widget _buildFeaturedView() {
    return Column(
      children: [
        _header(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Öne Çıkan İlanlar',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => setState(() => _navIndex = 1),
                      child: const Text('Tümünü Gör',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.80,
                    ),
                    itemCount: _allJobs.length,
                    itemBuilder: (context, index) {
                      final job = _allJobs[index];
                      return JobCard(
                        job: job,
                        onTap: () => Navigator.pushNamed(context, '/detail',
                            arguments: job),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Mavi başlık + (LinkedIn tarzı) arama çubuğu.
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Hoş Geldin 👋',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 2),
                  Text('Ahmet Yılmaz',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => _navIndex = 2),
                child: const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => setState(() => _navIndex = 1),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: AppColors.textMuted),
                  SizedBox(width: 8),
                  Text('İş ara...',
                      style: TextStyle(color: AppColors.textMuted)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
