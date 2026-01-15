import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppPaths {
  static Future<Directory> getApplicationDirectory() async {
    // For Desktop (Windows/Linux), we use getApplicationSupportDirectory
    // to avoid admin permission issues.
    final dir = await getApplicationSupportDirectory();
    return dir;
  }

  static Future<File> getDatabaseFile() async {
    final dir = await getApplicationDirectory();
    return File(p.join(dir.path, 'zeentech.db'));
  }

  static Future<Directory> getPhotosDirectory() async {
    final dir = await getApplicationDirectory();
    final photosDir = Directory(p.join(dir.path, 'photos'));
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }
    return photosDir;
  }

  static Future<void> init() async {
    // Ensure directories exist on startup
    await getPhotosDirectory();
  }
}
