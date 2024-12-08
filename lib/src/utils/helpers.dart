import 'package:intl/intl.dart';

class Helpers {
  static String getNamedDate(dynamic input) {
    if (input == null || input == '') {
      return "-";
    }

    DateTime date;
    if (input is String) {
      try {
        date = DateTime.parse(input);
      } catch (e) {
        return "-";
      }
    } else if (input is DateTime) {
      date = input;
    } else {
      return "-";
    }

    final weekday = _getWeekdayName(date.weekday);
    final day = date.day;
    final month = _getMonthName(date.month);
    final year = date.year;
    final hour = date.hour;
    final minute = date.minute;

    return '$weekday, $day $month $year $hour:$minute';
  }

  static String _getWeekdayName(int weekday) {
    const weekdays = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    return weekdays[weekday - 1];
  }

  static String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }

  static String formatRupiah(int value) {
    final formatter = NumberFormat('#,##0', 'id_ID');
    return 'Rp ${formatter.format(value)}';
  }
}
