import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_type.dart';


void main() {
  group('Bill type tests', () {
    test('Should throw domain exception when value is empty', () {
      expect(() => BillType.create(''), throwsA(const TypeMatcher<DomainException>()));
    });

  ///Test no longer needed with null safety turned on
  /*
    test('Should throw domain exception when value is null', () {
      expect(() => BillType.create(null), throwsA(const TypeMatcher<DomainException>()));
    });
  */

    test('Should create new bill type when value is not null or empty', () {
      String string = '\u{1F39E}  ' + 'Entertainment';
      var bill = BillType.create(string);
      expect(bill.billType, string);
    });
  });
}