<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Widget for Multi Select Form Field with able customize most of the UI.

## Features

With MultiSelectFormField you can able to achieve multi select form field with 
existing flutter Form widget.

with MultiSelectFormField you can customize options and chips.

## Getting started

```dart
    import 'package:multi_select/multi_select.dart';
```

## Usage

```dart
class SampleMultiSelect extends StatefulWidget {
  const SampleMultiSelect({Key? key}) : super(key: key);

  @override
  State<SampleMultiSelect> createState() => _SampleMultiSelectState();
}

class _SampleMultiSelectState extends State<SampleMultiSelect> {
  final options = const <Option>[
    Option<Color>(label: "Red", value: "Red", extra: Colors.red),
    Option<Color>(label: "Blue", value: "Blue", extra: Colors.blue),
    Option<Color>(label: "green", value: "Green", extra: Colors.green),
    Option<Color>(label: "Orange", value: "Orange", extra: Colors.orange),
  ];

  late MultiSelectController controller;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = MultiSelectController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi Select"),
        actions: [],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("+"),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            print("Validated");
          }
        },
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ChipsBuilder(
                  controller: controller,
                  builder: (options) {
                    return Wrap(
                      children: options
                          .map((e) => Chip(
                                label: Text(e.label),
                                backgroundColor: e.extra,
                              ))
                          .toList(),
                    );
                  }),
              SizedBox(
                height: 80,
              ),
              MultiSelectFormField(
                controller: controller,
                options: options,
                validator: (val) {
                  if (val?.isEmpty ?? true) {
                    return "Options is required";
                  }
                  return null;
                },
                chipBuilder: (option, index) {
                  return Chip(
                    label: Text(option.label),
                    backgroundColor: option.extra,
                  );
                },
                onShowOptions: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return _showOptions();
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showOptions() {
    return OptionsBuilder(
        controller: controller,
        builder: (option, index, isChoosed) {
          return CheckboxListTile(
              value: isChoosed,
              title: Text(option.label),
              onChanged: (value) {
                controller.onChange(option);
              });
        });
  }
}

```

