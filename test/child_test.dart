

import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/children/childen.dart';

void main(){
  test("description", (){
    final name = Stud("name");

    List<int> grade = [1, 2, 5];
    name.setName = "Kolya";
    final result = name.getName();


    expect(result, "Kolya");
  });
}
