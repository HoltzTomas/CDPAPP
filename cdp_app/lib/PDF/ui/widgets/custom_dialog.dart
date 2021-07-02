import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key, this.child, this.button}) : super(key: key);

  final Widget? child;
  final Widget? button;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: 20, top: 45 + 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: widget.button == null
              ? widget.child
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.child!,
                    const SizedBox(height: defaultPadding),
                    Align(
                        alignment: Alignment.bottomRight, child: widget.button),
                  ],
                ),
        ),
        Positioned(
          right: 7,
          top: 20,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 35,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(45),
              ),
              child: Image.asset("assets/icons/app_icon.png"),
            ),
          ),
        ),
      ],
    );
  }
}
