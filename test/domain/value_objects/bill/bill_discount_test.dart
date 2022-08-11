import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_discount.dart';

void main() {
  group('Bill discount tests', () {
    test('Should throw a domain exception when the cashValue is below 0.0', () {
      expect(() => Discount.create(dollarValue: -1),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test(
        'Should throw a domain exception when the percentageValue is below 0.0',
        () {
      expect(() => Discount.create(percentageValue: -1),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test(
        'Should set default values to 0.0 if nothing is entered at time of creation',
        () {
      var discount = Discount.create();
      expect(discount.dollarValue, 0.0);
      expect(discount.percentageValue, 0.0);
    });

    test(
        'Should set cashValue to entered value of 5.0 representing \$5 discount',
        () {
      var discount = Discount.create(dollarValue: 5.0);
      expect(discount.dollarValue, 5.0);
    });
  });
}
