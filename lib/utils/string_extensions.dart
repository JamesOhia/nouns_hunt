extension StringCasingExtension on String {
  String toCapitalize() {
    if (isEmpty) {
      return "";
    }

    var result = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }
}

extension StringFormatExtension on String {
  String formatAsCategory() {
    if (isEmpty) {
      return "";
    }

    return replaceAll("_", " ").replaceAll("and", "&").toCapitalize();
  }

  String formatAsRank() {
    if (isEmpty) {
      return "";
    }

    // switch (this) {
    //   case "1":
    //     return "1st";
    //   case "2":
    //     return "2nd";
    //   case "3":
    //     return "3rd";
    //   default:
    //     return this;
    // }

    return "${this}${getRankSuffix()}";
  }

  String getRankSuffix() {
    if (isEmpty) {
      return "";
    }

    switch (this) {
      case "1":
        return "st";
      case "2":
        return "nd";
      case "3":
        return "rd";
      default:
        return "th";
    }
  }
}
