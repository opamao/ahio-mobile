import 'package:intl/intl.dart';

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

}

String formatDate(String inputDate) {
  DateTime dateTime = DateTime.parse(inputDate);
  String formattedDate = DateFormat('dd MMMM yyyy', 'fr').format(dateTime);
  return formattedDate;
}

String formatDates(String inputDate) {
  List<String> parts = inputDate.split('-');
  if (parts.length != 3) {
    return 'Format de date invalide';
  }

  int? day = int.tryParse(parts[0]);
  int? month = int.tryParse(parts[1]);
  int? year = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) {
    return 'Format de date invalide';
  }

  // Liste des noms de mois en français
  List<String> monthNames = [
    '', 'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
    'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
  ];

  if (month < 1 || month > 12) {
    return 'Mois invalide';
  }

  String formattedDate = '$day ${monthNames[month]} $year';
  return formattedDate;
}


String formatDateTime(String inputDateTime) {
  DateTime dateTime = DateFormat('dd/MM/yyyy').parse(inputDateTime);
  String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
  return formattedDateTime;
}