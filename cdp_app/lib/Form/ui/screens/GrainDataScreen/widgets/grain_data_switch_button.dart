import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrainDataSwitchButton extends ConsumerWidget {
  const GrainDataSwitchButton(
      {Key? key,
      required this.onChanged,
      required this.providerToChange,
      this.dataWeWantReceive})
      : super(key: key);

  final String? dataWeWantReceive;
  final Function(bool) onChanged;
  final StateProvider<bool> providerToChange;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      margin: const EdgeInsets.all(defaultPadding / 2),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(
          dataWeWantReceive!,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            decoration: TextDecoration.underline
          ),
        ),
        value: watch(providerToChange).state,
        onChanged: onChanged,
      ),
    );
  }
}
