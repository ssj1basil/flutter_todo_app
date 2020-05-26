import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AppState  {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readContent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      print('successfully read' + contents);
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }


  Future<File> writeContent(String text) async {
    final file = await _localFile;
    // Write the file
    print('successfully written '+ text);
    return file.writeAsString(text);
  }





}