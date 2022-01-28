

import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/children/childen.dart';

void main(){
  final name = Stud("name");
  List<int> grade = [2, 2, 5, 0, 0, 0, 0, 0, 0, 0];

  test("description", (){

    name.setName = "Kolya";
    final result = name.getName();

    expect(result, "Kolya");


  });

  test("test_setGrades", (){

    name.setGrades = grade;
    final result = name.getGrades();

    expect(result, [2, 2, 5, 0, 0, 0, 0, 0, 0, 0]);
  });

  test("test_setGradesByIndex", (){
    name.setGradeByIndex(5, 1);

    final result = name.getGrade(1);


    expect(result, 5);
  });

  test("test_setGradesByIndex(false index)", (){
    final result = name.setGradeByIndex(5, -1);

    expect(result, false);
  });

  test("test_setGradesByIndex(false grade)", (){
    final result = name.setGradeByIndex(6, 1);

    expect(result, false);
  });

  test("test_Average", (){
    name.getAverage();

    final result = name.getAverage();


    expect(result, 4.0);
  });

}