import 'package:flutter_test/flutter_test.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/entities/bill.dart';
import 'package:split_the_bill/domain_layer/entities/item.dart';
import 'package:split_the_bill/domain_layer/entities/user.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_date.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_discount.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_extra_fees.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_name.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_tax.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_type.dart';
import 'package:split_the_bill/domain_layer/value_objects/item/item_name.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_email.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_first_name.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_last_name.dart';
import 'package:matcher/matcher.dart' as matcher;
import 'package:uuid/uuid.dart';

///NOTE: There are no tests for the item and user entities as they contain no
/// business logic and the validation is done in their associated value objects.
/// To see their tests please look into test/domain/value_objects.


void main() {

  Item testItem1 = Item(
      billID: '',
      itemID: const Uuid().v1(),
      itemName: ItemName.create('test item 1'),
      price: 9.99,
      userID: const Uuid().v1());

  Item testItem2 = Item(
      billID: '',
      itemID: const Uuid().v1(),
      itemName: ItemName.create('test item 2'),
      price: 22.22,
      userID: const Uuid().v1());

  User testUser1 = User(
      userID: const Uuid().v1(),
      firstName: FirstName.create('Serena'),
      lastName: LastName.create('Z'),
      email: Email.create('Serena@gmail.com'));

  User testUser2 = User(
      userID: const Uuid().v1(),
      firstName: FirstName.create('John'),
      lastName: LastName.create('Smith'),
      email: Email.create('John@gmail.com'));

  Bill testBill = Bill(
      billID: const Uuid().v1(),
      billName: BillName.create('test1'),
      billType: BillType.create('a'),
      date: BillDate.create('2022-05-04'),
      extraFees: ExtraFees.create(dollarValue: 5.0),
      discount: Discount.create(),
      tax: Tax.create(tax: 5.0),
      items: {},
      users: [],
      splitEqually: true);

  Bill testBill2 = Bill(
      billID: const Uuid().v1(),
      billName: BillName.create('test2'),
      billType: BillType.create('type'),
      date: BillDate.create('2022-05-04'),
      extraFees: ExtraFees.create(dollarValue: 5.0),
      discount: Discount.create(),
      tax: Tax.create(tax: 5.0),
      items: {testItem1.itemID: 1, testItem2.itemID: 3},
      users: [testUser1, testUser2],
      splitEqually: true);

  Bill testBill3 = Bill(
      billID: const Uuid().v1(),
      billName: BillName.create('test3'),
      billType: BillType.create('type'),
      date: BillDate.create('2022-05-04'),
      extraFees: ExtraFees.create(dollarValue: 5.0),
      discount: Discount.create(),
      tax: Tax.create(tax: 5.0),
      items: {testItem1.itemID: 1, testItem2.itemID: 3},
      users: [testUser2],
      splitEqually: true);

  group('bill tests', () {
    group('add item to bill function', () {
      test('empty bill - add single item to bill', () {
        final newBill = testBill.addItemToBill(testItem1.itemID, 1);
        expect(newBill.items, {testItem1.itemID: 1});
      });

      test('empty bill - add two items to bill', () {
        final newBill =
            testBill.addItemToBill(testItem1.itemID, 1).addItemToBill(testItem2.itemID, 1);
        expect(newBill.items, {testItem1.itemID: 1, testItem2.itemID: 1});
      });

      test('empty bill - add item twice', () {
        final newBill =
            testBill.addItemToBill(testItem1.itemID, 1).addItemToBill(testItem1.itemID, 1);
        expect(newBill.items, {testItem1.itemID: 2});
      });

      test('empty bill - add three items to bill', () {
        final newBill = testBill.addItemToBill(testItem1.itemID, 3);
        expect(newBill.items, {testItem1.itemID: 3});
      });

      test('FAILURE TEST - Adding a quantity of 0 or less should throw DomainException', () {
        expect(() => testBill.addItemToBill(testItem1.itemID, 0),
            throwsA(matcher.TypeMatcher<DomainException>()));
      });
    });

    group('Update item quantity on bill tests', () {
      test('Increase quantity of test item by 1 on bill should succeed', () {
        final newBill = testBill2.updateItemQuantity(testItem1.itemID, 1);
        expect(newBill.items, {testItem1.itemID: 2, testItem2.itemID: 3});
      });

      test('Increase quantity of test item by 3 on bill should succeed', () {
        final newBill = testBill2.updateItemQuantity(testItem1.itemID, 3);
        expect(newBill.items, {testItem1.itemID: 4, testItem2.itemID: 3});
      });

      test('Decrease quantity of test item by 1 on bill should succeed', () {
        final newBill = testBill2.updateItemQuantity(testItem2.itemID, -1);
        expect(newBill.items, {testItem1.itemID: 1, testItem2.itemID: 2});
      });

      test('Decrease quantity of test item by 2 on bill should succeed', () {
        final newBill = testBill2.updateItemQuantity(testItem2.itemID, -2);
        expect(newBill.items, {testItem1.itemID: 1, testItem2.itemID: 1});
      });

      test('Using updateItemQuantity with a value of 0 should do nothing', () {
        final newBill = testBill2.updateItemQuantity(testItem1.itemID, 0);
        expect(newBill.items, {testItem1.itemID: 1, testItem2.itemID: 3});
      });

      test(
          'Decrease quantity of test item by 3 with original quantity of 3 should remove item',
          () {
        final newBill = testBill2.updateItemQuantity(testItem2.itemID, -3);
        expect(newBill.items, {testItem1.itemID: 1});
      });
    });

    group('remove item from bill function', () {
      test('Try to delete item from bill', () {
        final newBill = testBill2.deleteItemFromBill(testItem1.itemID);
        expect(newBill.items, {testItem2.itemID: 3});
      });
    });

    group('Add User To Bill function', () {
      test('Should successfully add user to a bill', () {
        final newBill = testBill.addUserToBill(testUser1);
        expect(newBill.users, [testUser1]);
      });

      test('FAILURE TEST - Should fail if user already exists on bill', () {
        expect(() => testBill2.addUserToBill(testUser1),
            throwsA(matcher.TypeMatcher<DomainException>()));
      });
    });

    group('Remove User From Bill Function', () {
      test('Should successfully remove user from a bill', () {
        final newBill = testBill2.removeUserFromBill(testUser1);
        expect(newBill.users, [testUser2]);
      });

      test('FAILURE TEST - Should fail if user is not on bill', () {
        expect(() => testBill3.removeUserFromBill(testUser1),
            throwsA(matcher.TypeMatcher<DomainException>()));
      });
    });
  });
}
