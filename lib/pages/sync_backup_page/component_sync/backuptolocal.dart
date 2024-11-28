import 'package:flutter/material.dart';
import 'package:smart_storage/constants.dart';

class BackupToLocal extends StatefulWidget {
  const BackupToLocal({Key? key}) : super(key: key);

  @override
  _BackupToLocalState createState() => _BackupToLocalState();
}

class _BackupToLocalState extends State<BackupToLocal> {
  bool isBackingUp = false; // Trạng thái backup

  void toggleBackup() {
    setState(() {
      isBackingUp = !isBackingUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Backup to Local',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Constants.blueDarkGray,
        centerTitle: true,
        elevation: 4,
      ),
      body: Center( // Bọc nội dung trong Center để căn giữa
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa nội dung theo chiều ngang
            children: [
              Icon(
                isBackingUp ? Icons.cloud_upload : Icons.cloud_done,
                size: 100,
                color: isBackingUp ? Colors.blueAccent : Colors.green,
              ),
              const SizedBox(height: 20),
              Text(
                isBackingUp ? 'Backing up your data...' : 'Backup complete!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isBackingUp ? Colors.blueAccent : Colors.green,
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
                  backgroundColor: isBackingUp
                      ? Colors.redAccent
                      : Colors.blueAccent, // Thay đổi màu nút khi đang backup
                ),
                onPressed: toggleBackup,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isBackingUp ? Icons.cancel : Icons.cloud_upload, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      isBackingUp ? 'Stop Backup' : 'Start Backup',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              if (isBackingUp)
                Column(
                  children: [
                    const LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      minHeight: 8,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Saving your data to local storage...',
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
