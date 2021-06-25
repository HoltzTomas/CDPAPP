import 'package:cdp_app/Form/model/destination.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/Form/ui/screens/DestinationScreen/widgets/destination_alert_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DestinationBottomSheet extends StatelessWidget {
  final String? tipo;
  final String? text;
  final StateProvider<Destination?>? providerToChange;

  ///"Procedencia de la mercaderia" is an special fact [GrainDataForm].
  ///
  ///So, we use this instead of [GrainDataBottomSheet]
  const DestinationBottomSheet(
      {Key? key,
      @required this.text,
      @required this.tipo,
      this.providerToChange})
      : super(key: key);

  Widget addDataButton(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DestinationAlertDialog(
                      tipo: tipo,
                      text: text,
                    );
                  },
                );
              },
              child: const Text(
                "Agregar",
                style: TextStyle(color: darkColor),
              ),
            ),
          ),
        ],
      );

  Widget dataList() {
    final FormCloudRepository formCloudRepository = FormCloudRepository();
    final FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(auth.currentUser!.uid)
          .doc('userData')
          .collection('destination')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return Column(
              children: formCloudRepository.buildDestination(
                  list: snapshot.data!.docs,
                  providerToChange: providerToChange),
            );
        }
      },
    );
  }

  Widget title() => Container(
        alignment: Alignment.center,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(),
      ),
      child: Column(
        children: [
          const SizedBox(height: defaultPadding / 2),
          title(),
          dataList(),
          addDataButton(context),
        ],
      ),
    );
  }
}
