import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_name.dart';

void main() {
  group('Bill name tests', () {
    test('Should throw domain exception when value is empty', () {
      expect(() => BillName.create(''),
          throwsA(const matcher.TypeMatcher<DomainException>()));
    });

    ///Test no longer needed with null safety turned on
    /*
    test('Should throw domain exception when value is null', () {
      expect(() => BillName.create(null),
          throwsA(const matcher.TypeMatcher<DomainException>()));
    });
    */
    test('Should create new bill name when value is not null or empty', () {
      String string = 'Legends Bar and Grill';
      var bill = BillName.create(string);
      expect(bill.billName, string);
    });
  });
}
