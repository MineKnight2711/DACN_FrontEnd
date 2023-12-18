import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/language_controller.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:get/get.dart';

class LanguageSlider extends StatefulWidget {
  const LanguageSlider({super.key});

  @override
  State<LanguageSlider> createState() => _LanguageSliderState();
}

class _LanguageSliderState extends State<LanguageSlider>
    with SingleTickerProviderStateMixin {
  final languageController = Get.find<LanguageController>();
  final Duration _duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<Offset> _arrowAnimation;
  late Animation<Offset> _buttonsAnimation;
  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _arrowAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _buttonsAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _isButtonVisible = false;
    super.dispose();
  }

  void _toggleButtonVisibility() {
    setState(() {
      _isButtonVisible = !_isButtonVisible;
      if (_isButtonVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _toggleButtonVisibility,
      leading: const Icon(Icons.language),
      title: Text(
        tr("more.account_info.language"),
        style: CustomFonts.customGoogleFonts(
          fontSize: 14.r,
        ),
      ),
      trailing: AnimatedContainer(
        duration: _duration,
        alignment: Alignment.centerRight,
        width: _isButtonVisible ? 160.w : 50.w,
        child: !_isButtonVisible
            ? SlideTransition(
                position: _arrowAnimation,
                child: const Icon(CupertinoIcons.arrow_right),
              )
            : SlideTransition(
                position: _buttonsAnimation,
                child: OverflowBox(
                  maxWidth: 160.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          languageController
                              .saveLocale(const Locale('en', 'US'))
                              .whenComplete(() {
                            context.setLocale(const Locale('en', 'US'));

                            showDelayedLoadingAnimation(context,
                                    "assets/animations/loading.json", 180, 1)
                                .whenComplete(() => Phoenix.rebirth(context));
                            _toggleButtonVisibility();
                          });
                        },
                        child: Text(
                          "English",
                          style: CustomFonts.customGoogleFonts(
                              fontSize: 14.r, color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          languageController
                              .saveLocale(const Locale('vi', 'VN'))
                              .whenComplete(() {
                            context.setLocale(const Locale('vi', 'VN'));
                            showDelayedLoadingAnimation(context,
                                    "assets/animations/loading.json", 180, 1)
                                .whenComplete(() => Phoenix.rebirth(context));
                            _toggleButtonVisibility();
                          });
                        },
                        child: Text(
                          "Tiếng việt",
                          style: CustomFonts.customGoogleFonts(
                              fontSize: 14.r, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
