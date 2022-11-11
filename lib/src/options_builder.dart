import 'package:flutter/material.dart';

import 'multi_select_controller.dart';
import 'types.dart';

///Builder for handle options provided in the [MultiSelectFormField].
class OptionsBuilder extends StatelessWidget {
  final MultiSelectController controller;

  ///This builder will iterate over options.
  final OptionBuilder builder;

  ///Builder for handle options provided in the [MultiSelectFormField].
  ///
  ///You must indicate [controller] that values changed.
  ///show use [controller.onChange] method and provide changed option.
  const OptionsBuilder(
      {super.key, required this.controller, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, values, child) {
          return ListView.builder(
              itemCount: controller.getOptions().length,
              itemBuilder: (_, index) {
                final op = controller.getOptions()[index];
                final isChoosed = values.contains(op);
                return builder(op, index, isChoosed);
              });
        });
  }
}
