import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

Logger _logger = Get.find();
DatabaseReference _db = FirebaseDatabase.instance.ref();

class Categories {
  static Map<String, List<String>> spCategories = {};
  static Map<String, Map<String, dynamic>> mpCategories = {};

  static Future<void> load() async {
    _logger.d("loading categories");

    _db.child('categories/sp').once().then((event) {
      var snapshot = event.snapshot;
      if (!snapshot.exists) {
        _logger.d("No data found for sp categories");
      }

      (snapshot.value! as Map).forEach((key, value) {
        spCategories[key] = List.from(value);
      });
    });

    _db.child('categories/mp').once().then((event) {
      var snapshot = event.snapshot;
      if (!snapshot.exists) {
        _logger.d("No data found for mp categories");
      }

      (snapshot.value! as Map).forEach((key, value) {
        if (!mpCategories.containsKey(key)) {
          mpCategories[key] = {"difficulty": 0, "words": []};
        }

        mpCategories[key]?["difficulty"] = value["difficulty"];
        mpCategories[key]?["words"] = List.from(value["words"]);
      });
      _logger.d("loaded mp categories", mpCategories);
    });
  }

  static Future<bool> checkWordInCategory(
      {required String word, required String category}) async {
    if (!spCategories.containsKey(category.toLowerCase())) {
      _logger.d("Category $category does not exist");
      return false;
    }

    return spCategories[category.toLowerCase()]!.contains(word.toLowerCase());
  }
}
