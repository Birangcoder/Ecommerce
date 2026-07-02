class CategoryModel {
  final String name;
  final String slug;
  final String image;

  CategoryModel({required this.name, required this.slug, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json, String image) {
    return CategoryModel(name: json['name'], slug: json['slug'], image: image);
  }
}
