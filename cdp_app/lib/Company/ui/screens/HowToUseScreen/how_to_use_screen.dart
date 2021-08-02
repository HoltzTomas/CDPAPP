import 'package:cdp_app/Company/ui/screens/HowToUseScreen/widgets/issue_cdp_example.dart';
import 'package:cdp_app/Company/ui/screens/HowToUseScreen/widgets/upload_file_example.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class HowToUseScreen extends StatefulWidget {
  ///This screens shows the user how to use CDP APP
  const HowToUseScreen({Key? key}) : super(key: key);

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  int itemSelected = 0;

  List<Widget> items() => const [UploadFileExample(), IssueCDPExample()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text("¿Cómo usar CDP APP?"),
      ),
      body: items()[itemSelected],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: itemSelected,
        selectedItemColor: primaryColor,
        unselectedItemColor: darkColor,
        onTap: (value) {
          setState(() {
            itemSelected = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: "Subir archivo"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Emitir CDP"),
        ],
      ),
    );
  }
}
