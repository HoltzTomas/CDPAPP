import 'package:cdp_app/Company/ui/screens/HomeScreen/widgets/home_drawer.dart';
import 'package:cdp_app/PDF/ui/screens/PdfsScreen/pdfs_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Archivos de Cartas de Porte",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      drawer: const HomeDrawer(),
      body: const PdfsScreen(),
    );
  }
}
