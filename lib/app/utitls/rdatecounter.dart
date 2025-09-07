//calculate date difference in days

int calculateDateDifferenceInDays(DateTime startDate, String endDate) {
  return DateTime.parse(endDate).difference(startDate).inDays;
}
