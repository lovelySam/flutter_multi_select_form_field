import 'package:flutter/material.dart';

import 'multi_select_controller.dart';
import 'types.dart';

///This builder will be useful incase selected chips need to diplay outside the scope of [MultiSelectFormField].
class ChipsBuilder extends StatelessWidget {
  final MultiSelectController controller;

  ///This builder will iterate over selected [options]
  final ChipListBuilder builder;
  const ChipsBuilder(
      {super.key, required this.controller, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, values, child) {
          return builder(values);
        });
  }
}
