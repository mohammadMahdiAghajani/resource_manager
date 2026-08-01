bool validateDate(String date) {
  final c = date.split('-');
  if (c.length == 3 &&
      c[0].length == 4 &&
      c[1].length == 2 &&
      c[2].length == 2) {
    return true;
  } else {
    return false;
  }
}
