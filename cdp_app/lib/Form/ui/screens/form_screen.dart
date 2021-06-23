import 'package:cdp_app/Form/ui/screens/GrainDataScreen/grain_data_screen.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_form.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/transfer_data_screen.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  /// Here the user will give us some data that we need to create the PDF later
  const FormScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final tabs = <Tab>[
      const Tab(text: "Traslado"),
      const Tab(text: "Granos"),
      const Tab(text: "Destino"),
      const Tab(text: "Transporte"),
      const Tab(text: "D.J"),
    ];
    final tabsPages = [
      const TransferDataScreen(),
      const GrainDataScreen(),
      Container(),
      Container(),
      Container(),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: false,
          title: const Text(
            "Llenar carta de porte",
            style: TextStyle(
              color: darkColor,
            ),
          ),
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(children: tabsPages),
      ),
    );
  }
}
