int saveInt(d) {
  if (d is int) {
    return d;
  } else if (d is double) {
    return d.round();
  } else if (d is String) {
    return int.tryParse(d) ?? 0;
  } else {
    return 0;
  }
}
