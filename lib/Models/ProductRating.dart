class ProductRating {
  final double rate;
  final int count;

  const ProductRating({
    required this.rate,
    required this.count,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    final rate = switch (json['rate']) {
      double rate => rate,
      int rate => rate.toDouble(),
      _ => throw const FormatException('Invalid rate type'),
    };

    return switch (json) {
      {
        'count': int count,
      } =>
        ProductRating(rate: rate.toDouble(), count: count),
      _ => throw const FormatException('Failed to load product.'),
    };
  }
}
