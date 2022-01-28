import 'package:flutter/material.dart';

class Stud{
  static const int SIZE = 10;
  final List<int> _grades = [0, 0, 0, 5, 0, 0, 0, 0, 0, 0];
  late String _name;
  int _gradesCount = 10;

  Stud(String name){
   _name =  name.isNotEmpty ? name : "NULL";
  }

  @visibleForTesting
  set setName(String name) => _name = name;

  set setGrades(List<int> grade){
    int index = 0;
    if (SIZE - _gradesCount >= grade.length){
      for(int i in grade) {
        if (i > 1 && i < 6) {
          _grades[index];
          index++;
        } else {
          return;
        }
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
      for(int i in _grades){
        sum += i;
      }
      return sum / _gradesCount;
    }
    return 0.0;
  }

  String getName() => _name;

  List<int> getGrades() => _grades;


}