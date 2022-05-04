

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Capitalisation on String {
  String capitalise(){
    return this[0].toUpperCase() + substring(1);
  }
}


extension DateParse on DateTime{
  String asString(){
    return DateFormat.yMMMMd().format(this);
  }

  DateTime noTime(){
    return DateTime(year,month,day);
  }
}

extension DateRangeParser on DateTimeRange{
  String asString() {
    DateTime s = start.noTime();
    DateTime e = end.noTime();

    if (e.isAtSameMomentAs(s)){
      return start.asString();
    }
    return "${start.asString()} to ${end.asString()}";
  }


  List<DateTime> todateList(){
    List<DateTime> dates = [start.noTime()];
    DateTime current = start.noTime();
    while (!current.isAtSameMomentAs(end.noTime())){
      dates.add(current);
      current = current.noTime().add(const Duration(days: 1));
    }
    return dates;
  }
}