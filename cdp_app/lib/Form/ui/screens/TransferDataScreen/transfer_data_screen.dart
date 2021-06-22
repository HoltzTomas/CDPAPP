import 'package:cdp_app/Form/ui/screens/TransferDataScreen/widgets/transfer_data_form.dart';
import 'package:cdp_app/Form/ui/widgets/form_screen_title.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class TransferDataScreen extends StatelessWidget {
  ///The PDF needs five different types of data.
  ///TransferData, GrainData, Destination,TransportData
  ///and SwornDeclarationData
  ///Here we will receive TransferData
  const TransferDataScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            FormScreenTitle(text: "1- Datos de Traslado"),
            SizedBox(height: defaultPadding),
            TransferDataForm(),
            SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}