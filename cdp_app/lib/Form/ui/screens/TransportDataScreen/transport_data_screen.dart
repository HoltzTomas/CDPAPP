import 'package:cdp_app/Form/ui/screens/TransportDataScreen/widgets/transport_data_form.dart';
import 'package:cdp_app/Form/ui/widgets/form_screen_title.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class TransportDataScreen extends StatelessWidget {
  ///The PDF needs four different types of data.
  ///TransferData, GrainData, Destination and TransportData
  ///
  ///Here we will receive TransferData
  const TransportDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            FormScreenTitle(text: "4- Datos de Transporte"),
            SizedBox(height: defaultPadding),
            TransportDataForm(),
            SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
