import 'package:matcher/matcher.dart' as matcher;
import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_date.dart';

void main() {
  group('Bill date tests', () {

    test('Should throw domain exception when date is not properly formatted', () {
      expect(() => BillDate.create('1989.04.17'),
          throwsA(const matcher.TypeMatcher<DomainException>()));
    });

    test('Should throw domain exception when date is empty', () {
      expect(() => BillDate.create(''), throwsA(const TypeMatcher<DomainException>()));
    });

  ///Test no longer needed with null safety turned on
  /*
    test('Should throw domain exception when date is null', () {
      expect(() => BillDate.create(null), throwsA(const TypeMatcher<DomainException>()));
    });
  */

    test('Should set date if date is valid', () {
      var dateString = '1989-04-14';
      var date = BillDate.create(dateString);
      expect(date.toDate(), DateTime(1989, 04, 14));
    });
  });
}
