class DateCompareException implements Exception {
  late String? message;

  DateCompareException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "DateCompareException";
    return "DateCompareException: $message";
  }
}

class Date {
  late int _year;
  late int _month;
  late int _day;

  Date({int? year, int? month, int? day}) {
    DateTime now = DateTime.now();

    year ??= now.year;
    month ??= now.month;
    day ??= now.day;

    int? maxDay = switch (month) {
      1 || 3 || 5 || 7 || 8 || 10 || 12 => 31,
      4 || 6 || 9 || 11 => 30,
      2 => 28,
      _ => null
    };

    if (year < 0) {
      throw ArgumentError(
        "Недействительный год. "
        "Год не может быть отрицательным",
      );
    }

    if (maxDay == null) {
      throw ArgumentError(
        "Недействительный месяц. "
        "Ожидается номер месяца от 1 до 12",
      );
    }

    if (day > maxDay || day <= 0) {
      throw ArgumentError(
        "Недействительный день. "
        "Ожидается корректный день месяца",
      );
    }

    _year = year;
    _month = month;
    _day = day;
  }

  @override
  bool operator ==(Object other) {
    if (other is Date) return hashCode == other.hashCode;

    return false;
  }

  bool operator >(Object other) => _compareDates(this, other);
  bool operator <(Object other) => _compareDates(other, this);

  bool operator >=(Object other) => _compareDates(this, other, strict: true);
  bool operator <=(Object other) => _compareDates(other, this, strict: true);

  @override
  String toString() {
    return "$_yearг. $_month месяц $_day день";
  }

  @override
  int get hashCode => int.parse(
        "${_year.toString().padLeft(4, '0')}"
        "${_month.toString().padLeft(2, '0')}"
        "${_day.toString().padLeft(2, '0')}",
      );

  bool _compareDates(
    Object firstDate,
    Object secondDate, {
    bool strict = false,
  }) {
    if (firstDate is! Date || secondDate is! Date) {
      throw DateCompareException("Сравнивание даты с другим типом");
    }

    DateTime firstDateTime = DateTime(
      firstDate._year,
      firstDate._month,
      firstDate._day,
    );
    DateTime secondDateTime = DateTime(
      secondDate._year,
      secondDate._month,
      secondDate._day,
    );

    return switch (firstDateTime.compareTo(secondDateTime)) {
      1 => true,
      -1 => false,
      0 => strict,
      _ => false
    };
  }
}
