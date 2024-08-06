import 'package:flutter/material.dart';
import 'package:tasksmanager/constants/AppColor.dart';

class Customtextformfield extends StatelessWidget {
  TextEditingController controller;
  String lableText;
  TextInputType textInputType;
  bool obscureText;
  String? Function(String?)? validator;
  bool isPassword;
  Function()? onIconPressed;
  bool isShown;
  Customtextformfield(
      {super.key,
      required this.controller,
      required this.lableText,
      required this.textInputType,
      this.obscureText = false,
      required this.validator,
      required this.isPassword,
      this.isShown = false,
      this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: textInputType,
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: isPassword == true
              ? isShown == false
                  ? IconButton(
                      onPressed: onIconPressed,
                      icon: const Icon(
                        Icons.visibility,
                        color: AppColor.primaryLightColor,
                      ),
                    )
                  : IconButton(
                      onPressed: onIconPressed,
                      icon: const Icon(
                        Icons.visibility_off,
                        color: AppColor.primaryLightColor,
                      ),
                    )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColor.primaryLightColor,
            ),
          ),
          floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
          errorStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColor.deleteColor,
              ),
          errorMaxLines: 2,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColor.deleteColor,
            ),
          ),
          labelText: lableText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColor.primaryLightColor,
            ),
          ),
        ),
      ),
    );
  }
}
