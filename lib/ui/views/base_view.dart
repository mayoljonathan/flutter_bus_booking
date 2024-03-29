import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_booking/locator.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  BaseView({this.builder, this.onModelReady});

  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {

  T model = locator<T>();

  @override
  void initState() {
    super.initState();
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('Disposing $model');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Consumer<T>(builder: widget.builder)
    );
  }
}