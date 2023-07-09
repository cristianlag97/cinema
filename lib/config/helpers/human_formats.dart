part of config.helpers;

class HumanFormats {
  static String number(double number, [int decimals = 0]) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formatterNumber;
  }

  static String shortDate(DateTime date, String language) {
    final format = DateFormat.yMMMEd(language);
    return format.format(date);
  }
}
