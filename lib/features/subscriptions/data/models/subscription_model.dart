

class SubscriptionModel {
  final String slug;
  final String name;
  final String shortDescription;
  final String description;
  final SubscriptionImage image;
  final List<String> authors;
  final List<String> features;

  SubscriptionModel({
    required this.slug,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.image,
    required this.authors,
    required this.features,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      slug: json['identifier']['slug'] as String,
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      description: json['description'] as String,
      image: SubscriptionImage.fromJson(json),
      authors: (json['authors'] as List)
          .map((author) => author['name'] as String)
          .toList(),
      features: (json['features'] as List)
          .map((feature) => feature['title'] as String)
          .toList(),
    );
  }
}

class SubscriptionImage {
  final String small;
  final String large;

  SubscriptionImage({
    required this.small,
    required this.large,
  });

  factory SubscriptionImage.fromJson(Map<String, dynamic> json) {
    return SubscriptionImage(
      small: json['imageSmall'] as String,
      large: json['imageLarge'] as String,
    );
  }
}
