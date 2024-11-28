
import 'package:flutter/material.dart';
import 'package:smart_storage/constants.dart';

class Sync extends StatefulWidget {
  const Sync({Key? key}) : super(key: key);

  @override
  _SyncState createState() => _SyncState();
}

class _SyncState extends State<Sync> {
  bool isSyncing = false; // Trạng thái đồng bộ

  void toggleSync() {
    setState(() {
      isSyncing = !isSyncing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sync Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Constants.blueDarkGray,
        centerTitle: true,
        elevation: 4,
      ),
      body: Center( // Bọc Column bên trong Center
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa nội dung trong Column
            children: [
              Icon(
                isSyncing ? Icons.sync : Icons.cloud_sync,
                size: 100,
                color: isSyncing ? Colors.blueAccent : Colors.grey,
              ),
              const SizedBox(height: 20),
              Text(
                isSyncing ? 'Syncing in progress...' : 'Ready to Sync',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isSyncing ? Colors.blueAccent : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: isSyncing
                      ? Colors.redAccent
                      : Colors.blueAccent, // Thay đổi màu khi đồng bộ
                ),
                onPressed: toggleSync,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isSyncing ? Icons.cancel : Icons.sync, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      isSyncing ? 'Stop Sync' : 'Start Sync',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              if (isSyncing)
                Column(
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Syncing your data, please wait...',
                      style: TextStyle(fontSize: 18, color: Colors.blueAccent[700]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
