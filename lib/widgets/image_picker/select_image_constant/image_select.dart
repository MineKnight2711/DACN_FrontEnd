import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery_fe/config/constant.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../selectphoto/select_photo_options_screen.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File?) onImageSelected;
  final String? currentImageUrl;

  const ImagePickerWidget(
      {Key? key, required this.onImageSelected, this.currentImageUrl})
      : super(key: key);

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget>
    with SingleTickerProviderStateMixin {
  File? image;
  late AnimationController _animationController;
  late Animation<double> _inanimation;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await cropImage(imageFile: img);

      setState(() {
        this.image = img;
      });
      widget.onImageSelected(img);
      _animationController.forward(from: 0.0);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {
      Navigator.of(context).pop();
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: pickImage,
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _inanimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (image != null) ...[
          Stack(
            children: [
              ScaleTransition(
                scale: _inanimation,
                child: Container(
                  width: CustomMediaQuerry.mediaWidth(context, 4),
                  height: CustomMediaQuerry.mediaHeight(context, 7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: CustomMediaQuerry.mediaHeight(context, 3),
                    backgroundImage: Image.file(
                      image!,
                    ).image,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    showSelectPhotoOptions(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: mainButtonColor,
                    radius: CustomMediaQuerry.mediaAspectRatio(context, 1 / 37),
                    child: Icon(
                      Icons.camera_alt,
                      size: CustomMediaQuerry.mediaAspectRatio(context, 1 / 40),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ] else ...[
          Stack(
            children: [
              Container(
                width: CustomMediaQuerry.mediaWidth(context, 3),
                height: CustomMediaQuerry.mediaHeight(context, 7),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainAppThemeColor,
                ),
                child: ClipOval(
                  child: widget.currentImageUrl != null
                      ? Image.network(
                          widget.currentImageUrl!,
                          fit: BoxFit.cover,
                          width: CustomMediaQuerry.mediaWidth(context, 4),
                          height: CustomMediaQuerry.mediaHeight(context, 7),
                        )
                      : Image.asset(
                          'assets/images/profile.png',
                          scale: CustomMediaQuerry.mediaWidth(context, 4),
                        ),
                ),
              ),
              const SizedBox(height: 8),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    showSelectPhotoOptions(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: mainButtonColor,
                    radius: CustomMediaQuerry.mediaAspectRatio(context, 1 / 37),
                    child: Icon(
                      Icons.camera_alt,
                      size: CustomMediaQuerry.mediaAspectRatio(context, 1 / 40),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ],
    );
  }
}
