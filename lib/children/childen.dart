import 'package:flutter/material.dart';

class Stud{
  final List<int> _grades = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  late String _name;
  static const int _gradesCount = 10;

  Stud(String name){
    _name =  name.isNotEmpty ? name : "NULL";
  }

  @visibleForTesting
  set setName(String name) => _name = name;

  set setGrades(List<int> grade){
    int index = 0;
    if (grade.length <= _gradesCount){
      for(int i in grade) {
        _grades[index] = i;
        index++;
      }
    } else {
      return;
    }
  }

  bool setGradeByIndex(int grade, int index){
    if (index > -1 && index <= _gradesCount) {
      if (grade > 1 && grade < 6) {
        _grades[index] = grade;
        return true;
      }
    }
    return false;
  }

  int getGrade(int index){
    return index > -1 && index <= _gradesCount ? _grades[index] : 0;
  }

  double getAverage (){
    if (_gradesCount != 0) {
      double sum = 0;
      int count = 0;
      for(int i in _grades){
        if (i > 0) {
          sum += i;
          count++;
        }
      }
      return sum / count;
    }
    return 0.0;
  }

  String getName() => _name;

  List<int> getGrades() => _grades;


}