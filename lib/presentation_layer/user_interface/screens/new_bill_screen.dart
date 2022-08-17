import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/domain_layer/factories/IEntityFactory.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_date.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_extra_fees.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_name.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/split_the_bill_equally_screen.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/split_the_bill_unequally_screen.dart';
import 'package:uuid/uuid.dart';
import '../../../domain_layer/entities/bill.dart';
import '../../../domain_layer/value_objects/bill/bill_discount.dart';
import '../../../domain_layer/value_objects/bill/bill_tax.dart';
import '../../../domain_layer/value_objects/bill/bill_type.dart';
import '../../animations/animated_toggle.dart';
import '../widgets/general_app_bar.dart';
import '../widgets/home_app_bar.dart';

//TODO: The entirety of the split equally pages and functionally needs to be redone.
//TODO: Adjust font sizes, page aesthetics, etc

class NewBillScreen extends StatefulWidget {
  const NewBillScreen(
      {Key? key, required this.billController, required this.entityFactory})
      : super(key: key);

  final BillController billController;
  final IEntityFactory entityFactory;

  @override
  State<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends State<NewBillScreen> {
  var newBillNameController = TextEditingController();
  var newBillTypeController = TextEditingController();
  var newBillDateController = TextEditingController();
  var newBillExtraFeesDVController = TextEditingController();
  var newBillExtraFeesPVController = TextEditingController();
  var newBillExtraFeesTipController = TextEditingController();
  var newBillDiscountDVController = TextEditingController();
  var newBillDiscountPVController = TextEditingController();
  var newBillTaxController = TextEditingController();

  var _billTypeOptions;
  var _selectedBillType;
  bool _isNameValid = true;
  bool _isTypeValid = true;
  bool _isDateValid = true;
  int _splitBillEqually = 0;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  //TODO: Redo fields, names, wrap in form container, move controllers to new file or list
  //TODO: Add validators to fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: generalAppBar(context),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
        child: Column(
          children: <Widget>[
            Container(height: 10),
            const Text(
              'Is this bill being split equally?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            AnimatedToggle(
              values: const ['Unequally', 'Equally'],
              onToggleCallback: (value) {
                setState(() {
                  _splitBillEqually = value;
                });
              },
              buttonColor: const Color(0xFF6EC6CA),
              backgroundColor: Colors.white,
              textColor: Colors.black,
            ),
            Container(height: 10),
            const Text(
              'Bill name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextFormField(
              controller: newBillNameController,
              decoration: InputDecoration(
                hintText: 'Name or description of bill (required)',
                hintStyle: TextStyle(
                    fontSize: 17,
                    color: _isDateValid == true
                        ? const Color(0xFF787d87)
                        : Colors.red),
              ),
            ),
            Container(height: 10),
            const Text(
              'Bill type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            _buildDropDownMenu(),
            Container(height: 10),
            const Text(
              'Bill date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: newBillDateController,
              onTap: () {
                _selectBillDate(context);
              },
              decoration: InputDecoration(
                hintText: 'The date on the bill (required)',
                hintStyle: TextStyle(
                    fontSize: 17,
                    color: _isDateValid == true
                        ? const Color(0xFF787d87)
                        : Colors.red),
                prefixIcon: const InkWell(
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(height: 10),
            const Text(
              'Extra fees - dollar value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Container(height: 5),
            TextField(
              controller: newBillExtraFeesDVController,
              decoration: const InputDecoration(
                  hintText:
                  "Enter extra fees dollar value (e.g. \$5 surcharge)"),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ], // Only numbers can be entered
            ),
            Container(height: 10),
            const Text(
              'Extra fees - percentage value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Container(height: 5),
            TextField(
              controller: newBillExtraFeesPVController,
              decoration: const InputDecoration(
                  hintText:
                  "Enter extra fees percentage value (e.g. 5% surcharge)"),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ], // Only numbers can be entered
            ),
            Container(height: 10),
            const Text(
              'Tip value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Container(height: 5),
            TextField(
              controller: newBillExtraFeesTipController,
              decoration: const InputDecoration(
                  hintText: "Enter tip amount if applicable"),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ], // Only numbers can be entered
            ),
            Container(height: 10),
            const Text(
              'Discount - dollar value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: newBillDiscountDVController,
              decoration: const InputDecoration(
                  hintText: "Enter discount amount - dollar value"),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ], // Only numbers can be entered
            ),
            Container(height: 10),
            const Text(
              'Discount - percentage value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: newBillDiscountPVController,
              decoration: const InputDecoration(
                  hintText: "Enter discount amount - percentage value"),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ], // Only numbers can be entered
            ),
            Container(height: 10),
            const Text('Tax - percentage value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
            TextField(
              controller: newBillTaxController,
              decoration: const InputDecoration(
                  hintText: "Enter tax percentage (ex: 5%)"),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
            ),
            Container(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8), elevation: 8),
              onPressed: () async {
                _setNewBill();
              },
              child: const Text(
                'Split this bill',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDropDownMenu() {
    return DropdownButtonFormField<dynamic>(
      value: _billTypeOptions,
      validator: (value) => value == null ? 'Type is required' : null,
      items: [
        '\u{1F39E}  ' 'Entertainment',
        '\u{1F3E0}  ' 'Rent',
        '\u{1F354}  ' 'Restaurant',
        '\u{1F6CD}  ' 'Shopping',
        '\u{1F6E9}  ' 'Travel',
        '\u{26A1}  ' 'Utilities',
        '\u{1F4B2}  ' 'OTHER',
      ]
          .map((range) =>
          DropdownMenuItem(
            value: range,
            child: Text(
              range.toString(),
              style: const TextStyle(fontSize: 20),
            ),
          ))
          .toList(),
      hint: Text(
        'Select bill type (required)',
        style: TextStyle(
          fontSize: 17,
          color: _isTypeValid == true ? const Color(0xFF787d87) : Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
      onChanged: (value) {
        _selectedBillType = value;
        setState(() {
          _billTypeOptions = value;
        });
      },
    );
  }

  _setNewBill() async {
    setState(() {
      newBillNameController.text.isEmpty
          ? _isNameValid = false
          : _isNameValid = true;
      _selectedBillType == null ? _isTypeValid = false : _isTypeValid = true;
      newBillDateController.text.isEmpty
          ? _isDateValid = false
          : _isDateValid = true;
    });


    Bill bill = widget.entityFactory.newBill(
        billID: const Uuid().v1(),
        billName: BillName.create(newBillNameController.text),
        billType: BillType.create(_selectedBillType),
        date: BillDate.create(newBillDateController.text),
        extraFees: ExtraFees.create(
            dollarValue: double.parse(newBillExtraFeesDVController.text),
            percentageValue: double.parse(newBillExtraFeesPVController.text),
            tip: double.parse(newBillExtraFeesTipController.text)),
        discount: Discount.create(
            dollarValue: double.parse(newBillDiscountDVController.text),
            percentageValue: double.parse(newBillDiscountPVController.text)),
        tax: Tax.create(tax: double.parse(newBillTaxController.text)),
        items: {},
        users: [],
        splitEqually: _splitBillEqually == 0 ? true : false);
    //TODO: Adjust this logic
    if (_isNameValid == true && _isTypeValid == true) {
      var result = await widget.billController.addBill(bill);
      if (result > 0) {
        _showSuccessfulNewBill();
        _splitBillEqually == 0
            ? Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (context) =>
                SplitTheBillUnequallyScreen(billInputID: bill.billID)))
            .then((value) => setState(() {}))
            : Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (context) =>
                SplitTheBillEquallyScreen(billInputID: bill.billID)))
            .then((value) => setState(() {}));
      } else {
        _showNewBillFailure();
      }
    }
  }

  _selectBillDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      setState(() {
        _dateTime = pickedDate;
        newBillDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  _showSuccessfulNewBill() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Created new bill',
          textAlign: TextAlign.center,
        )));
  }

  _showNewBillFailure() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error creating new bill',
          textAlign: TextAlign.center,
        )));
  }
}
