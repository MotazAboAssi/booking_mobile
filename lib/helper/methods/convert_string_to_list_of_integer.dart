List<int> convertStringToListOfInteger(String input) {
  final String content = input.replaceAll('[', '').replaceAll(']', '');
  return content.trim().isEmpty
      ? []
      : content.trim().split(',').map((e) => int.parse(e.trim())).toList();
}
