import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../state/app_state.dart';

/// Ayarlar ekranı: tercihler (karanlık mod gerçekten çalışır) + çıkış.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _emailUpdates = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: const Text('Ayarlar',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        _sectionTitle('Tercihler'),
        _switchTile(context, 'Bildirimler',
            'İlan güncellemeleri için bildirim al', _notifications,
            (v) => setState(() => _notifications = v)),
        _switchTile(context, 'E-posta Güncellemeleri',
            'Yeni ilanları e-posta ile al', _emailUpdates,
            (v) => setState(() => _emailUpdates = v)),
        // Karanlık mod: AppState'e bağlı, tüm uygulamayı etkiler
        ValueListenableBuilder<bool>(
          valueListenable: AppState.instance.darkMode,
          builder: (context, isDark, _) => _switchTile(
            context,
            'Karanlık Mod',
            'Koyu tema kullan',
            isDark,
            (v) => AppState.instance.darkMode.value = v,
          ),
        ),
        const SizedBox(height: 8),
        _sectionTitle('Hesap'),
        _navTile(context, Icons.lock_outline, 'Gizlilik ve Güvenlik'),
        _navTile(context, Icons.help_outline, 'Yardım ve Destek'),
        _navTile(context, Icons.info_outline, 'Hakkında'),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Çıkış Yap',
                  style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(text,
          style: const TextStyle(
              color: AppColors.textMuted,
              fontWeight: FontWeight.bold,
              fontSize: 13)),
    );
  }

  Widget _switchTile(BuildContext context, String title, String subtitle,
      bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SwitchListTile(
          title: Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle,
              style:
                  const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          value: value,
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _navTile(BuildContext context, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          trailing:
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title yakında eklenecek')),
            );
          },
        ),
      ),
    );
  }
}
