import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_first_name.dart';

void main() {
  group('User first name tests', () {
    test('Should throw domain exception when input is empty', () {
      expect(() => FirstName.create(''),
          throwsA(const TypeMatcher<DomainException>()));
    });

  ///Test no longer needed with null safety turned on
  /*
    test('Should throw domain exception when input is null', () {
      expect(() => FirstName.create(null),
          throwsA(const TypeMatcher<DomainException>()));
    });
   */

    test('Should throw domain exception when input is greater than 40 chars', () {
      var inputString = 'abcde1abcde2abcde3abcde4abcde5abcde6abcde7';
      expect(() => FirstName.create(inputString), throwsA(const TypeMatcher<DomainException>()));
    });

    test('Should create new first name when value is not empty or null', () {
      String string = 'Serena';
      var userFirstName = FirstName.create(string);
      expect(userFirstName.firstName, string);
    });
  });
}
