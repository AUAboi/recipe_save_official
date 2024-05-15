enum Unit {
  kilogram,
  gram,
  liter,
  milliliter,
}

class Ingredient {
  final String name;
  final double quantity;
  final Unit unit;

  Ingredient({required this.name, required this.quantity, required this.unit});
}
