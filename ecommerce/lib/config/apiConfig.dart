class Api {
  static const baseUrl = "https://dummyjson.com";

  static const login = "$baseUrl/auth/login";

  static const products = "$baseUrl/products";

  static const categories = "$baseUrl/products/categories";

  static String product(int id) => "$baseUrl/products/$id";

  static String search(String query) => "$baseUrl/products/search?q=$query";

  static String category(String name) => "$baseUrl/products/category/$name";

  static String cart(int id) => "$baseUrl/carts/$id";

  static String user(int id) => "$baseUrl/users/$id";

  static String currentUser = "$baseUrl/auth/me";

}
