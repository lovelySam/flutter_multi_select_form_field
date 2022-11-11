import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_select_form_field/src/controller_base.dart';
import 'package:flutter_multi_select_form_field/src/option.dart';

/// A controller for multi select field.
///
class MultiSelectController extends ValueNotifier<List<Option>>
    implements MultiSelectControllerBase {
  List<Option> _options = [];
  List<Option> _selected = [];

  ///Creates a controller for  multi select field.
  MultiSelectController() : super(const []);

  @override
  List<Option> get value => _selected;

  ///Used to update [selected] options.
  ///
  ///if [option] is already selected then [option] will be removed otherwise will be added in [selected] options.
  @override
  void onChange(Option option) {
    if (_selected.contains(option)) {
      _selected.remove(option);
    } else {
      _selected.add(option);
    }
    notifyListeners();
  }

  ///This method is used to remove all selected options.
  @override
  void removeAll() {
    _selected.clear();
    notifyListeners();
  }

  ///This method is used to get all selected options.
  @override
  List<Option> getSelectedOptions() {
    return _selected;
  }

  ///This method is used to set options.
  @override
  void setOptions(List<Option> options) {
    _options = options;
    notifyListeners();
  }

  ///This method is used to get options.
  @override
  List<Option> getOptions() {
    return _options;
  }
}
