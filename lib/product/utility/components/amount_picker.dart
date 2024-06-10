import 'package:flutter/material.dart';

class AmountPicker extends StatefulWidget {
  const AmountPicker({super.key, this.initialAmount = 1, this.onAmountChanged});

  final int initialAmount;
  final ValueChanged<int>? onAmountChanged;

  @override
  _AmountPickerState createState() => _AmountPickerState();
}

class _AmountPickerState extends State<AmountPicker> {
  late int _amount;

  @override
  void initState() {
    super.initState();
    _amount = widget.initialAmount;
  }

  void _incrementQuantity() {
    setState(() {
      _amount++;
      widget.onAmountChanged?.call(_amount);
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_amount > 1) {
        _amount--;
        widget.onAmountChanged?.call(_amount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrementQuantity,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '$_amount',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _incrementQuantity,
        ),
      ],
    );
  }
}
