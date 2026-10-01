import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../local/app_database.dart';

class PlateItem {
  final LocalFood food;
  final double grams;
  final String? portionLabel;

  const PlateItem({
    required this.food,
    required this.grams,
    this.portionLabel,
  });

  /// Total carbohydrate grams for this plate entry: (grams / 100) * carbsGPer100g
  double get totalCarbsG => (grams / 100.0) * food.carbsGPer100g;

  PlateItem copyWith({
    double? grams,
    String? portionLabel,
  }) {
    return PlateItem(
      food: food,
      grams: grams ?? this.grams,
      portionLabel: portionLabel ?? this.portionLabel,
    );
  }
}

class PlateState {
  final List<PlateItem> items;

  const PlateState({this.items = const []});

  /// Total carbohydrates of all items on the plate
  double get totalCarbsG => items.fold(0.0, (sum, item) => sum + item.totalCarbsG);

  /// 15g Turkish carbohydrate exchange units
  double get exchangeUnits => totalCarbsG / 15.0;

  /// Lowest verification confidence level on the plate
  String get lowestVerificationStatus {
    if (items.isEmpty) return 'official_verified';
    for (final item in items) {
      if (item.food.verification == 'community_unverified' ||
          item.food.verification == 'user_entered') {
        return item.food.verification;
      }
    }
    return 'official_verified';
  }
}

class PlateNotifier extends Notifier<PlateState> {
  @override
  PlateState build() {
    return const PlateState();
  }

  void addItem(LocalFood food, double grams, [String? portionLabel]) {
    final existingIndex = state.items.indexWhere((i) => i.food.id == food.id);
    if (existingIndex >= 0) {
      final updatedList = List<PlateItem>.from(state.items);
      final current = updatedList[existingIndex];
      updatedList[existingIndex] = current.copyWith(
        grams: current.grams + grams,
      );
      state = PlateState(items: updatedList);
    } else {
      state = PlateState(
        items: [
          ...state.items,
          PlateItem(food: food, grams: grams, portionLabel: portionLabel),
        ],
      );
    }
  }

  void updateItemGrams(int index, double newGrams) {
    if (index >= 0 && index < state.items.length) {
      final updated = List<PlateItem>.from(state.items);
      if (newGrams <= 0) {
        updated.removeAt(index);
      } else {
        updated[index] = updated[index].copyWith(grams: newGrams);
      }
      state = PlateState(items: updated);
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < state.items.length) {
      final updated = List<PlateItem>.from(state.items)..removeAt(index);
      state = PlateState(items: updated);
    }
  }

  void clearPlate() {
    state = const PlateState(items: []);
  }
}

final plateProvider = NotifierProvider<PlateNotifier, PlateState>(
  PlateNotifier.new,
);
