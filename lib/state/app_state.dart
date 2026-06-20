import 'package:flutter/foundation.dart';

/// Uygulama genelinde paylaşılan basit durum (state).
/// ValueNotifier kullanıyoruz: değer değişince dinleyen widget'lar
/// (ValueListenableBuilder) otomatik yeniden çizilir.
class AppState {
  AppState._();
  static final AppState instance = AppState._();

  final ValueNotifier<Set<int>> favorites = ValueNotifier<Set<int>>({});
  final ValueNotifier<Set<int>> applied = ValueNotifier<Set<int>>({});
  final ValueNotifier<bool> darkMode = ValueNotifier<bool>(false);

  void toggleFavorite(int id) {
    final current = Set<int>.from(favorites.value);
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    favorites.value = current;
  }

  void apply(int id) {
    final current = Set<int>.from(applied.value);
    current.add(id);
    applied.value = current;
  }
}
