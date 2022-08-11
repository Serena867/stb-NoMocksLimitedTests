import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_last_name.dart';

void main() {
  group('User last name tests', () {
    test('Should throw domain exception when input is empty', () {
      expect(() => LastName.create(''),
          throwsA(const TypeMatcher<DomainException>()));
    });

  ///Test no longer needed with null safety turned on
  /*
    test('Should throw domain exception when input is null', () {
      expect(() => LastName.create(null),
          throwsA(const TypeMatcher<DomainException>()));
    });
   */

    test(
        'Should throw domain exception when input is greater than 40 characters',
        () {
      var inputString = 'abcde1abcde2abcde3abcde4abcde5abcde6abcde7';
      expect(() => LastName.create(inputString),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test('Should create new last name when value is not empty or null', () {
      String string = 'Z';
      var userLastName = LastName.create(string);
      expect(userLastName.lastName, string);
    });
  });
}
