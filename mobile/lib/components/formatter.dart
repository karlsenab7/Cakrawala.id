class DateFormatter {
  int day;
  int month;
  int year;
  int hour;
  int minute;
  int second;

  DateFormatter(this.day, this.month, this.year, this.hour, this.minute, this.second);

  convertMonth(int monthNumber) {
    switch (monthNumber) {
      case 1: return "Jan";
      case 2: return "Feb";
      case 3: return "March";
      case 4: return "April";
      case 5: return "May";
      case 6: return "June";
      case 7: return "July";
      case 8: return "August";
      case 9: return "Sept";
      case 10: return "Oct";
      case 11: return "Nov";
      case 12: return "Dec";
    }
  }
  
  convertNumber(int dayNumber) {
    if (dayNumber<10) {
      return "0$dayNumber";
    }
    return dayNumber.toString();
  }

  @override
  String toString() {
    return "${convertNumber(day)} ${convertMonth(month)} ${year.toString()} ${convertNumber(hour)}:${convertNumber(minute)}:${convertNumber(second)}";
  }
}