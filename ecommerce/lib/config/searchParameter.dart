class Search {
  final String search;
  final String type;

  const Search({required this.search, required this.type});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Search && other.search == search && other.type == type;

  @override
  int get hashCode => Object.hash(search, type);
}
