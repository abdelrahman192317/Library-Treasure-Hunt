///calculate time for last update
String calculateTimeDifference(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);
  if (difference.isNegative) {
    return 'لم يبدأ بعد';
  } else if (difference.inDays >= 365) {
    int years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'سنة' : 'سنوات'} ';
  } else if (difference.inDays >= 30) {
    int months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'شهر' : 'شهور'} ';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'ايام'} ';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'} ';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'} ';
  } else {
    return 'قليل';
  }
}
