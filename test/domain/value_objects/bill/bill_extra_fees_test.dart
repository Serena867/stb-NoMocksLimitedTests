import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_extra_fees.dart';

void main() {
  group('Bill extra fees tests', () {
    test('Should throw domain exception if extra fees are negative value', () {
      expect(() => ExtraFees.create(dollarValue: -0.1),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test('Should set default value to 0.0 if nothing is entered', () {
      var extraFees = ExtraFees.create();
      expect(extraFees.dollarValue, 0.0);
      expect(extraFees.percentageValue, 0.0);
      expect(extraFees.tip, 0.0);
    });

    test('Should set extraFees to value of 5.0 representing \$5 in extra fees',
        () {
      var extraFees = ExtraFees.create(dollarValue: 5.0);
      expect(extraFees.dollarValue, 5.0);
      expect(extraFees.percentageValue, 0.0);
      expect(extraFees.tip, 0.0);
    });
  });
}
