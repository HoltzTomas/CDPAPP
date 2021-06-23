import 'package:cdp_app/Form/ui/screens/DestinationScreen/widgets/destination_form.dart';
import 'package:cdp_app/Form/ui/widgets/form_screen_title.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class DestinationScreen extends StatelessWidget {
  ///The PDF needs four different types of data.
  ///TransferData, GrainData, Destination and TransportData
  ///
  ///Here we will receive Destination
  const DestinationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            FormScreenTitle(text: "3- Destino"),
            SizedBox(height: defaultPadding),
            DestinationForm(),
            SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
