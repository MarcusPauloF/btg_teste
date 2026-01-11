class ImageModel {
  final String small;
  final String large;

  ImageModel({
    required this.small,
    required this.large,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      small: json['small'] as String,
      large: json['large'] as String,
    );
  }
}