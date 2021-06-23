import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_form.dart';
import 'package:cdp_app/Form/ui/widgets/form_screen_title.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class GrainDataScreen extends StatelessWidget {
  ///The PDF needs five different types of data.
  ///TransferData, GrainData, Destination,TransportData
  ///and SwornDeclarationData
  ///
  ///Here we will receive GrainData
  const GrainDataScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            FormScreenTitle(text: "2- Datos Granos"),
            SizedBox(height: defaultPadding),
            GrainDataForm(),
            SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}