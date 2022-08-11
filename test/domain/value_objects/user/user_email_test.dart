import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_email.dart';

void main() {
  group('User email tests', () {
    test('Should throw domain exception when input is empty', () {
      expect(() => Email.create(''),
          throwsA(const TypeMatcher<DomainException>()));
    });

  ///Test no longer needed with null safety turned on
  /*
    test('Should throw domain exception when input in null', () {
      expect(() => Email.create(null),
          throwsA(const TypeMatcher<DomainException>()));
    });
   */

    test('Should create new email when value is not empty or null', () {
      String string = 'Serena@gmail.com';
      var email = Email.create(string);
      expect(email.email, string);
    });
  });
}
