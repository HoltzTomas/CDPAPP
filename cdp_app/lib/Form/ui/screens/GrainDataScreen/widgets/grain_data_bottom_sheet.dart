import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/providers/grain_data_providers.dart';
import 'package:cdp_app/Form/repository/form_cloud_repository.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/add_grain_data_dialog.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_bottom_sheet_item.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrainDataBottomSheet extends StatelessWidget {
  final String? tipo;
  final String? text;
  final StateProvider<GrainData?>? providerToChange;

  const GrainDataBottomSheet(
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
                    return AddGrainDataDialog(
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
          const SizedBox(height: defaultPadding / 2),
        ],
      );

  Widget dataList() {
    final FormCloudRepository formCloudRepository = FormCloudRepository();
    final FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(auth.currentUser!.uid)
          .doc('userData')
          .collection('grainData')
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
              children: formCloudRepository.buildGrainData(
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
          border: Border.all()),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding / 2),
            title(),
            dataList(),
            addDataButton(context)
          ],
        ),
      ),
    );
  }
}
