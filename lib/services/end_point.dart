import '../utils/debug.dart';

abstract class EndPoint {
  static const liveURL = "https://fakestoreapi.com/";
  static const localURL = "https://fakestoreapi.com/";

  static const imageFilter = 'image/filter/';

  static getBaseURL() {
    if (Debug.sandboxApiUrl) {
      return localURL;
    } else {
      return liveURL;
    }
  }

  static const login = "auth/login";
  static const signUp = "users";
  static const allCategories = "products/categories";
  static const allCategoriesProduct = "products/category/";
  static const allProducts = "products";
  static const getPost = "/posts";
}
