import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../state/app_state.dart';
import 'favorites_screen.dart';

/// Profil ekranı. Favori/başvuru kartlarına dokununca Kaydedilenler açılır.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _openSaved(BuildContext context, int tab) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FavoritesScreen(initialTab: tab)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            children: const [
              CircleAvatar(
                radius: 44,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: AppColors.primary),
              ),
              SizedBox(height: 12),
              Text('Ahmet Yılmaz',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Frontend Geliştirici',
                  style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: ValueListenableBuilder<Set<int>>(
                  valueListenable: state.favorites,
                  builder: (context, favs, _) => _statCard(
                    context,
                    Icons.favorite,
                    favs.length.toString(),
                    'Favori İlan',
                    () => _openSaved(context, 0),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ValueListenableBuilder<Set<int>>(
                  valueListenable: state.applied,
                  builder: (context, applied, _) => _statCard(
                    context,
                    Icons.check_circle,
                    applied.length.toString(),
                    'Başvuru',
                    () => _openSaved(context, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _infoTile(context, Icons.email_outlined, 'E-posta', 'ahmet@ornek.com'),
        _infoTile(context, Icons.phone_outlined, 'Telefon', '+90 5XX XXX XX XX'),
        _infoTile(
            context, Icons.location_on_outlined, 'Konum', 'Ankara, Türkiye'),
        _infoTile(context, Icons.school_outlined, 'Eğitim',
            'Bilgisayar Programcılığı'),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _statCard(BuildContext context, IconData icon, String value,
      String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            Text(label,
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 12)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
