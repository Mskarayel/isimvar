# İşimVar 📱

İş ilanları kataloğu — Flutter ile geliştirilmiş mobil uygulama.

## Kısa Açıklama

İşimVar, iş ilanlarını listeleyen ve detaylarını gösteren bir mobil uygulamadır.
Kullanıcı ilanları arayabilir, favorilere ekleyebilir ve başvuru yapabilir.
İlan verileri yerel bir JSON dosyasından (`assets/jobs.json`) okunur.

### Özellikler
- 🔐 Giriş ekranı (UI)
- 🏠 Ana sayfa: ilan listesi (GridView ile kart tasarımı)
- 🔍 Arama / filtreleme
- 📄 İlan detay ekranı (Navigator + Route Arguments)
- ❤️ Favoriye ekleme (state yönetimi)
- ✅ İlana başvuru (state yönetimi)
- 📁 Model sınıfı + JSON okuma (asset yönetimi)

## Kullanılan Flutter Sürümü
- Flutter 3.44.2 (stable)
- Dart 3.12.2

## Çalıştırma Adımları
```bash
# bağımlılıkları yükle
flutter pub get

# bir emulator veya cihaz bağlıyken çalıştır
flutter run
```

## Klasör Yapısı
```
lib/
 ├─ main.dart              # uygulama girişi, tema, route'lar
 ├─ app_colors.dart        # renk paleti
 ├─ models/job.dart        # Job model (fromJson)
 ├─ services/job_service.dart  # JSON okuma
 ├─ state/app_state.dart   # favori & başvuru durumu
 ├─ widgets/job_card.dart  # tekrar kullanılabilir kart
 └─ screens/
     ├─ login_screen.dart  # giriş ekranı
     ├─ home_screen.dart   # ilan listesi + arama
     └─ detail_screen.dart # ilan detayı
assets/
 └─ jobs.json              # ilan verileri (simülasyon)
```
