import 'package:flutter_multi_select_form_field/src/option.dart';

abstract class MultiSelectControllerBase {
  void onChange(Option option);

  void removeAll();

  List<Option> getSelectedOptions();

  void setOptions(List<Option> options);

  List<Option> getOptions();
}
