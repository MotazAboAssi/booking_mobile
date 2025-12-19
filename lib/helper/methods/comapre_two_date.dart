int compareTwoDate(DateTime date1, DateTime date2) {
  if (date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day) {
    return 0;
  }
  if (date1.year <= date2.year) {
    if (date1.month <= date2.month) {
      if (date1.day < date2.day) {
        return -1;
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  } else {
    return 1;
  }
}
