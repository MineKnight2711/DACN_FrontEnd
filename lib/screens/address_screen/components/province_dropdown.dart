import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';

class ProvinceDropdown extends StatefulWidget {
  final String title;
  final List<dynamic> listDropDown;
  final ValueChanged<dynamic> onItemSelected;
  final bool enable;
  const ProvinceDropdown({
    Key? key,
    required this.onItemSelected,
    required this.listDropDown,
    required this.title,
    this.enable = true,
  }) : super(key: key);

  @override
  State<ProvinceDropdown> createState() => _ProvinceDropdownState();
}

class _ProvinceDropdownState extends State<ProvinceDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    super.initState();
  }

  void toggleDropdown() {
    _isOpen = !_isOpen;
    if (_isOpen) {
      setState(() {
        _animationController.forward();
      });
    } else {
      _animationController.reverse().whenComplete(() => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundIconButton(
          size: 100.r,
          title: widget.title,
          onPressed: widget.enable ? toggleDropdown : null,
        ),
        SizeTransition(
          sizeFactor: _animation,
          child: _isOpen ? _buildProvinceList() : Container(),
        ),
      ],
    );
  }

  Widget _buildProvinceList() {
    return SizedBox(
      height: 300.h,
      width: 200.w,
      child: ListView.builder(
        itemCount: widget.listDropDown.length,
        itemBuilder: (context, index) {
          final item = widget.listDropDown[index];
          return ListTile(
              onTap: () {
                _animationController
                    .reverse()
                    .whenComplete(() => setState(() {}));
                widget.onItemSelected(item);
              },
              leading: const Icon(Icons.location_on),
              title: Text(item.name));
        },
      ),
    );
  }
}
