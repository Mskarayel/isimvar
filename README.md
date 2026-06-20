# İşimVar 📱

İş ilanları kataloğu — Flutter ile geliştirilmiş mobil uygulama.

## Kısa Açıklama

İşimVar, iş ilanlarını listeleyen ve detaylarını gösteren bir mobil uygulamadır.
Kullanıcı ilanları arayıp filtreleyebilir, favorilere ekleyebilir ve başvuru yapabilir.
İlan verileri yerel bir JSON dosyasından (`assets/jobs.json`) okunur.

### Özellikler
- 🔐 Giriş ekranı
- 🏠 Ana sayfa: ilan listesi (GridView ile kart tasarımı)
- 🔍 İş Ara: arama + çalışma şekli / konum filtreleri
- 📄 İlan detay ekranı (Navigator + Route Arguments)
- ❤️ Favoriye ekleme ve ✅ başvuru (state yönetimi)
- 📑 Kaydedilenler: favori ve başvurulan ilanlar
- 🌙 Karanlık mod
- 📁 Model sınıfı + JSON okuma (asset yönetimi)

## Ekran Görüntüleri

| Giriş | Ana Sayfa | İş Ara |
|-------|-----------|--------|
| ![Giriş](Ekran%20resimleri/login.png) | ![Ana Sayfa](Ekran%20resimleri/homepage.png) | ![İş Ara](Ekran%20resimleri/is_Ara.png) |

| İlan Detayı | Profil | Kaydedilenler |
|-------------|--------|----------------|
| ![İlan Detayı](Ekran%20resimleri/ilan_detaylar%C4%B1.png) | ![Profil](Ekran%20resimleri/profile.png) | ![Kaydedilenler](Ekran%20resimleri/kaydedilenler.png) |

| Ayarlar | Karanlık Mod |
|---------|--------------|
| ![Ayarlar](Ekran%20resimleri/settings.png) | ![Karanlık Mod](Ekran%20resimleri/dark_settings.png) |

## Kullanılan Flutter Sürümü
- Flutter 3.44.2 (stable)
- Dart 3.12.2

## Çalıştırma Adımları
```bash
flutter pub get
flutter run
```

## Klasör Yapısı
```
lib/
 ├─ main.dart              # uygulama girişi, tema, route'lar
 ├─ app_colors.dart        # renk paleti + tema yardımcıları
 ├─ models/job.dart        # Job model (fromJson)
 ├─ services/job_service.dart  # JSON okuma
 ├─ state/app_state.dart   # favori, başvuru, karanlık mod durumu
 ├─ widgets/job_card.dart  # tekrar kullanılabilir kart
 └─ screens/
     ├─ login_screen.dart
     ├─ home_screen.dart
     ├─ search_screen.dart
     ├─ detail_screen.dart
     ├─ profile_screen.dart
     ├─ favorites_screen.dart
     └─ settings_screen.dart
```
