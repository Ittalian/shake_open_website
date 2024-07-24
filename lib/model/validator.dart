class Validator {
  final String? value;
  const Validator({required this.value});

  String? validateTitle() {
    if (value!.isEmpty) {
      return "入力してね";
    }
    return null;
  }

  String? validateUrl() {
    if (value!.isEmpty) {
      return "入力してね";
    } else if (!isValidUrl(value)) {
      return "URLが存在しません";
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
