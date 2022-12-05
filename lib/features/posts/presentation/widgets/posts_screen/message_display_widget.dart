// Packages
import 'package:flutter/material.dart';

// Core
import '../../../../../core/utils/app_colors.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onPress;

  const MessageDisplayWidget({
    Key? key,
    this.onPress,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.08,
                margin: const EdgeInsets.symmetric(vertical: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: AppColors.primary,
                    elevation: 500.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Text(
                    'reload_screen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    if (onPress != null) {
                      onPress!();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
