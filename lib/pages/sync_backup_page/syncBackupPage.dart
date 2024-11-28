import 'package:flutter/material.dart';
import 'package:smart_storage/constants.dart';
import 'component_sync/sync.dart';
import 'component_sync/user.dart';
import 'component_sync/backupfromlocal.dart';
import 'component_sync/backuptolocal.dart';

class syncBackupPage extends StatefulWidget {
  const syncBackupPage({super.key});

  @override
  State<syncBackupPage> createState() => _syncBackupPageState();
}

class _syncBackupPageState extends State<syncBackupPage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sync & Back Up',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Constants.blueDarkGray,
              centerTitle: true,
              elevation: 4,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildGradientButton(
                    label: 'Hello',
                    icon: Icons.person,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserScreen()));
                    },
                  ),
                  const SizedBox(height: 15),
                  buildGradientButton(
                    label: 'Sync',
                    icon: Icons.sync,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Sync()));
                    },
                  ),
                  const SizedBox(height: 15),
                  buildGradientButton(
                    label: 'Backup to local storage now!',
                    icon: Icons.backup,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BackupToLocal()));
                    },
                  ),
                  const SizedBox(height: 15),
                  buildGradientButton(
                    label: 'Backup files from local',
                    icon: Icons.download,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BackupFromLocal()));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGradientButton(
      {required String label,
      required IconData icon,
      required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Constants.blueDarkGray, Constants.blueLightGray],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
