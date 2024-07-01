import 'package:flutter_mob/configs/constants.dart';

class Utility {
  static double? toDouble(dynamic obj) {
    if (obj is int) {
      return obj.toDouble();
    } else if (obj is double) {
      return obj;
    } else {
      return null;
    }
  }

  static String getErrorMessage(String message) {
    if (message.contains("Exception: ")) {
      return message.split("Exception: ")[1];
    }

    return message;
  }

  static String roundNumberKilos(String number) {
    return number.contains('kg')
        ? (double.parse(number.substring(0, number.indexOf(" ")))
                .toStringAsFixed(0)) +
            (" ") +
            number.substring((number.length - 2).clamp(0, number.length))
        : ("${double.parse(number).toStringAsFixed(0)} lbs");
  }

  static double getAngleFromHourMinute(String date) {
    if (date.isEmpty) return 0;
    int hours = int.parse(date.split(':')[0]);
    int minutes = int.parse(date.split(':')[1].substring(0, 2));

    double hourInDegrees = (hours * 30);
    double minuteInDegrees = minutes * 0.5;
    double diff = (hourInDegrees + minuteInDegrees).abs();
    return diff - 90;
  }

  static double handleInterval(double value) {
    int interval = (value.toInt() / 3).ceil();
    return interval == 0 ? 1 : interval.toDouble();
  }

  static String convertHexToValue(String hexString) {
    int intValue = int.parse(hexString, radix: 16);
    return intValue.toString();
  }

  static String convertValueToHex(String value) {
    String hexString = int.parse(value).toRadixString(16).toUpperCase();
    return hexString;
  }

  static String formatNumberDoubleToInt(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }

  static String getMachineCategory(String type) {
    switch (type) {
      case StringName.AUTOMATIC_MECHANICAL_TYPE:
        return "Cơ tự động";
      case StringName.BATTERY_TYPE:
        return "Pin";
      case StringName.LIGHT_ENERGY_TYPE:
        return "Năng lượng mặt trời";
      default:
        return "";
    }
  }

  static String getWireCategory(String type) {
    switch (type) {
      case StringName.METAL_TYPE:
        return "Kim loại";
      case StringName.SKIN_TYPE:
        return "Da";
      case StringName.PLASTIC_TYPE:
        return "Nhựa";
      case StringName.FABRIC_TYPE:
        return "Vải";
      default:
        return "";
    }
  }
}
