String toCapitalize(String? input) {
  if (input != "" || input != null) {
    final List<String> sentance = input!.split(" ");
    List<String> resault = [];
    for (int i = 0; i < sentance.length; i++) {
      final String pharse = sentance[i];
      resault.add("${pharse[0].toUpperCase()}${pharse.substring(1)}");
    }

    return resault.join(" ");
  } else {
    return "";
  }
}
