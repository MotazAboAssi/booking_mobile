List<int> convertStringToListOfInteger(String input) {
  return input
      .replaceAll('[', '')
      .replaceAll(']', '')
      .split(',')
      .map((e) => int.parse(e.trim()))
      .toList();
}
