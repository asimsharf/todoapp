import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/the_colors.dart';

/*
 * theTextField is a widget that I created in the widgets folder
 * to make the code more readable and reusable
 */
Widget theTextField({context, controller, hintText}) {
  return TextField(
    controller: controller,
    onChanged: (value) {},
    textAlign: TextAlign.right,
    style: const TextStyle(
      color: TheColors.deepWhite,
    ),
    maxLengthEnforcement: MaxLengthEnforcement.enforced,
    decoration: InputDecoration(
      fillColor: TheColors.darkGrey,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(
        color: TheColors.whiteGrey,
        fontSize: 14,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );
}
