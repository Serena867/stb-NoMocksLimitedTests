import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_tax.dart';

void main() {
  group('Bill tax tests', () {

    ///Test no longer needed with null safety turned on
    /*
    test('Should throw domain exception if tax is null', () {
      expect(() => Tax.create(tax: null),
          throwsA(const TypeMatcher<DomainException>()));
    });
    */

    test('Should throw domain exception if tax is negative value', () {
      expect(() => Tax.create(tax: -0.1),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test('Should set default tax value to 0.0 if nothing is entered', () {
      var tax = Tax.create();
      expect(tax.tax, 0.0);
    });

    test('Should set tax value to 5.0 representing 5% tax', () {
      var tax = Tax.create(tax: 5.0);
      expect(tax.tax, 5.0);
    });
  });
}
