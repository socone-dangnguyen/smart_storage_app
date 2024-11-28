import 'package:flutter/material.dart';
import 'package:smart_storage/constants.dart';

class BackupFromLocal extends StatefulWidget {
  const BackupFromLocal({Key? key}) : super(key: key);

  @override
  _BackupFromLocalState createState() => _BackupFromLocalState();
}

class _BackupFromLocalState extends State<BackupFromLocal> {
  bool isRestoring = false; // Trạng thái khôi phục

  void toggleRestore() {
    setState(() {
      isRestoring = !isRestoring;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restore from Local',
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
                isRestoring ? Icons.cloud_download : Icons.cloud_done,
                size: 100,
                color: isRestoring ? Colors.blueAccent : Colors.green,
              ),
              const SizedBox(height: 20),
              Text(
                isRestoring ? 'Restoring your data...' : 'Restore complete!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isRestoring ? Colors.blueAccent : Colors.green,
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
                  backgroundColor: isRestoring
                      ? Colors.redAccent
                      : Colors.blueAccent, // Thay đổi màu nút khi khôi phục
                ),
                onPressed: toggleRestore,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isRestoring ? Icons.cancel : Icons.download, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      isRestoring ? 'Stop Restore' : 'Start Restore',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              if (isRestoring)
                Column(
                  children: [
                    const LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      minHeight: 8,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Retrieving data from local storage...',
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
