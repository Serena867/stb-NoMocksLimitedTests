import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/item/item_name.dart';

void main() {
  group('Item name tests', () {
    test('Should throw domain exception when input string is empty', () {
      expect(() => ItemName.create(''),
          throwsA(const TypeMatcher<DomainException>()));
    });

    ///Test no longer needed with null safety turned on
    /*
    test('Should throw domain exception when input string is null', () {
      expect(() => ItemName.create(null), throwsA(const TypeMatcher<DomainException>()));
    });
    */

    test('Should create new item name when value is not null or empty', () {
      String string = 'Legends Bar and Grill';
      var itemName = ItemName.create(string);
      expect(itemName.itemName, string);
    });
  });
}
