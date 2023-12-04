import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantityChooser extends StatefulWidget {
  final Function(int) onQuantityChanged;
  final int currentQuantity;
  const QuantityChooser(
      {super.key,
      required this.onQuantityChanged,
      required this.currentQuantity});

  @override
  State<QuantityChooser> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<QuantityChooser> {
  int _amount = 0;
  @override
  void initState() {
    super.initState();
    _amount = widget.currentQuantity;
  }

  void _increase() {
    setState(() {
      _amount++;
    });
    widget.onQuantityChanged(_amount);
  }

  void _decrease() {
    setState(() {
      if (_amount > 0) {
        _amount--;
      }
    });
    widget.onQuantityChanged(_amount);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _decrease,
          icon: const Icon(Icons.remove),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            _amount.toString(),
            style: GoogleFonts.roboto(fontSize: 22.r),
          ),
        ),
        IconButton(onPressed: _increase, icon: const Icon(Icons.add)),
      ],
    );
  }
}
