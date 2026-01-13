List<String> convertStringToListOfString(String input) {
  final String content = input.replaceAll('[', '').replaceAll(']', '');
  return content.trim().isEmpty
      ? []
      : content.trim().split(',').map((e) => e.trim()).toList();
}
