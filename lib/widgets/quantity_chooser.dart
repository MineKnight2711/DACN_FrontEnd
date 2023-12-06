import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantityChooser extends StatefulWidget {
  final Function(int) onQuantityChanged;
  final int? currentQuantity, minAmount;
  const QuantityChooser(
      {super.key,
      required this.onQuantityChanged,
      this.currentQuantity,
      this.minAmount});

  @override
  State<QuantityChooser> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<QuantityChooser> {
  int _amount = 0;
  int _minAmount = 0;
  @override
  void initState() {
    super.initState();
    _amount = widget.currentQuantity ?? 0;
    _minAmount = widget.minAmount ?? 0;
  }

  void _increase() {
    setState(() {
      if (widget.minAmount != null) {
        _minAmount++;
        widget.onQuantityChanged(_minAmount);
      } else {
        _amount++;
        widget.onQuantityChanged(_amount);
      }
    });
  }

  void _decrease() {
    setState(() {
      if (widget.minAmount != null) {
        if (_minAmount > widget.minAmount!) {
          _minAmount--;
          widget.onQuantityChanged(_minAmount);
        }
      } else {
        if (_amount > 0) {
          _amount--;
          widget.onQuantityChanged(_amount);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _decrease,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange100,
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.remove),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.minAmount != null
                ? _minAmount.toString()
                : _amount.toString(),
            style: GoogleFonts.roboto(fontSize: 22.r),
          ),
        ),
        ElevatedButton(
          onPressed: _increase,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange100,
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
