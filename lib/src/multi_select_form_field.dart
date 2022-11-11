import 'package:flutter/material.dart';
import 'package:flutter_multi_select_form_field/src/multi_select_controller.dart';
import 'package:flutter_multi_select_form_field/src/option.dart';
import "package:collection/collection.dart" show ListExtensions;
import 'package:flutter_multi_select_form_field/src/types.dart';

class MultiSelectFormField extends FormField<List<Option>> {
  /// [controller] is used to listen changes and .
  final MultiSelectController controller;

  ///used to build selected chips.
  final ChipBuilder? chipBuilder;

  ///Options to be build by [OptionsBuilder]
  final List<Option> options;

  ///Used to build errors widget.
  ///This builder will provide boolean and error string that passed by validator.
  ///This error builder will show error outside of [containerDecoration]
  final ErrorBuilder? errorBuilder;

  ///Decoration for Container.
  final Decoration? containerDecoration;

  ///Input decoration for input field
  final InputDecoration? decoration;

  ///This callback is used to invoke the options list.
  ///
  ///Option UI must be handled by you.
  final VoidCallback onShowOptions;

  ///if [showChips] is [false] chips will not displayed and [chipBuilder] will not be invoked.
  ///Default to true.
  ///
  ///You can use [ChipsBuilder] to build custom chips outside the scope of [MultiSelectFormField].
  final bool showChips;

  ///Multi select form field
  MultiSelectFormField({
    super.key,
    required this.onShowOptions,
    required this.controller,
    this.chipBuilder,
    this.options = const [],
    this.containerDecoration,
    this.decoration,
    this.errorBuilder,
    this.showChips = true,
    String? Function(List<Option>?)? validator,
    void Function(List<Option>?)? onSaved,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
  }) : super(
            validator: validator,
            onSaved: onSaved,
            autovalidateMode: autovalidateMode,
            enabled: enabled,
            initialValue: [],
            builder: (formState) {
              return ValueListenableBuilder<List<Option>>(
                  valueListenable: controller,
                  builder: (context, values, child) {
                    final theme = Theme.of(context);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: containerDecoration ??
                              BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (showChips && chipBuilder != null) ...[
                                Wrap(
                                  children: controller
                                      .getSelectedOptions()
                                      .mapIndexed((i, o) => chipBuilder(o, i))
                                      .toList(),
                                ),
                              ],
                              TextField(
                                readOnly: true,
                                onTap: onShowOptions,
                                decoration: decoration ??
                                    InputDecoration(
                                        hintText: "Choose...",
                                        hintStyle: theme
                                            .inputDecorationTheme.hintStyle),
                              ),
                            ],
                          ),
                        ),
                        if (formState.hasError) ...[
                          errorBuilder == null
                              ? Text(
                                  formState.errorText ?? "",
                                  style: theme.inputDecorationTheme.errorStyle,
                                )
                              : errorBuilder(
                                  formState.hasError, formState.errorText)
                        ]
                      ],
                    );
                  });
            }) {
    controller.setOptions(options);
  }

  @override
  FormFieldState<List<Option>> createState() =>
      _MultiSelectFormFieldState(controller);
}

class _MultiSelectFormFieldState extends FormFieldState<List<Option>> {
  final MultiSelectController controller;

  _MultiSelectFormFieldState(this.controller);

  @override
  void initState() {
    controller.addListener(() {
      didChange(controller.getSelectedOptions());
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
