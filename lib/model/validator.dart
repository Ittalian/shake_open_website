class Validator {
  final String? value;
  const Validator({required this.value});

  String? validateTitle() {
    if (value!.isEmpty) {
      return "入力してください";
    }
    return null;
  }

  String? validateUrl() {
    if (value!.isEmpty) {
      return "入力してください";
    } else if (!isValidUrl(value)) {
      return "URLの形式が違います";
    }
    return null;
  }

  bool isValidUrl(String? url) {
    // URLの正規表現
    if (url == null) return false;
    const urlPattern = r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$';
    final result = RegExp(urlPattern, caseSensitive: false).hasMatch(url);
    return result;
  }
}
