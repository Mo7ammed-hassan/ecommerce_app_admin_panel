import 'dart:io';

import 'package:ecommerce_app_admin_panel/core/utils/constants/constants.dart';
import 'package:ecommerce_app_admin_panel/core/utils/functions/error_show_dialog.dart';
import 'package:ecommerce_app_admin_panel/core/utils/styles/confirm_eleveted_button_style.dart';
import 'package:ecommerce_app_admin_panel/core/widgets/alert_dialog_content_decoration.dart';
import 'package:ecommerce_app_admin_panel/features/category/domain/entity/category_entity.dart';
import 'package:ecommerce_app_admin_panel/features/dashboard/presentation/views/widgets/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemSubmitForm extends StatefulWidget {
  const ItemSubmitForm({
    super.key,
    required this.itemNameController,
    required this.onSubmit,
    required this.formKey,
    required this.lableText,
    this.category,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController itemNameController;
  final Function(String itemName, File? image) onSubmit;
  final String lableText;
  final CategoryEntity? category;

  @override
  State<ItemSubmitForm> createState() => _ItemSubmitFormState();
}

class _ItemSubmitFormState extends State<ItemSubmitForm> {
  File? selectedImage;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void removeImage() {
    setState(() {
      selectedImage = null;
    });
  }

  @override
  void dispose() {
    widget.itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: AlertDialogContentDecoration(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: defaultPadding),
            Stack(
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: Card(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      height: MediaQuery.sizeOf(context).height * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                        image: selectedImage != null
                            ? DecorationImage(
                                image: FileImage(selectedImage!),
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
                      child: (selectedImage == null)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'main image',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                ),
                if (selectedImage != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: removeImage,
                    ),
                  )
              ],
            ),
            const SizedBox(height: defaultPadding),
            CustomTextField(
              controller: widget.itemNameController,
              maxLine: 1,
              labelText: '${widget.lableText} Name',
              onSave: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '${widget.lableText} name is required.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            ElevatedButton(
              style: confirmElevatedButtonStyle(),
              onPressed: () {
                if (widget.formKey.currentState!.validate()) {
                  if (selectedImage != null) {
                    widget.onSubmit(
                      widget.itemNameController.text,
                      selectedImage,
                    );
                  } else {
                    errorShowDialog(
                      context,
                      message: 'Please select an image.',
                    );
                  }
                }
              },
              child: const Text(
                'Confirm',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
