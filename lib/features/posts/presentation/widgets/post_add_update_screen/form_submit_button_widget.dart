// Packages
import 'package:flutter/material.dart';

class FormSubmitButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const FormSubmitButtonWidget({
    Key? key,
    required this.onPressed,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isUpdatePost ? const Icon(Icons.edit) : const Icon(Icons.add),
      label: Text(isUpdatePost ? 'Update' : 'Add'),
    );
  }
}
