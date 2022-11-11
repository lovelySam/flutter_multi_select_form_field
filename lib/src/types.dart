import 'package:flutter/material.dart';

import 'option.dart';

typedef OptionBuilder = Widget Function(Option, int, bool);

typedef ChipBuilder = Widget Function(Option, int);

typedef ErrorBuilder = Widget Function(bool, String?);

typedef ChipListBuilder = Widget Function(List<Option>);
