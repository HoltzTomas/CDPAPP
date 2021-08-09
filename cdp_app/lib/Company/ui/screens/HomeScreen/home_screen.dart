import 'package:cdp_app/Company/ui/screens/HomeScreen/widgets/home_drawer.dart';
import 'package:cdp_app/PDF/ui/screens/PdfsListScreen/pdfs_list_screen.dart';
import 'package:cdp_app/PDF/ui/screens/PdfsListScreen/widgets/upload_cdps_fab.dart';
import 'package:cdp_app/Subs/repository/pruchases_repository.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> initPlatformState() async {
    final PurchasesRepository purchasesRepository = PurchasesRepository();
    await purchasesRepository.checkSubStatus(context);
  }

  Future<void> checkVersion() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final newVersion = NewVersion();
      final status = await newVersion.getVersionStatus();
      if (status!.localVersion != status.storeVersion) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          allowDismissal: false,
          dialogText: "Descarga la nueva version antes de continuar",
          dialogTitle: "Actualizacion disponible",
          dismissButtonText: "Despues",
          updateButtonText: "Actualizar",
        );
      }
    }
  }

  @override
  void initState() {
    initPlatformState();
    checkVersion();
    super.initState();
  }

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
      body: const PdfsListScreen(),
      floatingActionButton: const UploadCdpsFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
