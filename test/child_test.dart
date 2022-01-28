

import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/children/childen.dart';

void main(){
  final name = Stud("name");
  List<int> grade = [2, 5];

  test("description", (){

    name.setName = "Kolya";
    final result = name.getName();

    expect(result, "Kolya");


  });

  test("test_setGrades", (){
    name.setGrades = grade;
    final result = name.getGrades();

    expect(result, [2, 2, 5]);
  });

  test("test_setGradesByIndex", (){
    List<int> grade = [1, 2, 5];
    name.setGradeByIndex(5, 1);

    final result = name.getGrade(1);


    expect(result, 5);
  });

}
