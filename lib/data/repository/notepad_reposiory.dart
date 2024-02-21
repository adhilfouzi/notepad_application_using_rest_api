import '../data_provider/notepad_data_provider.dart';

class NotepadRepository {
  Future<bool> delectById(String id) async {
    final response = await NotepadDataProvider.deleteNotepadData(id);
    return response == 200;
  }

  Future<List?> fetchNotepad() async {
    return await NotepadDataProvider.getNotepad();
  }

  Future<bool> updatedata(String id, Map body) async {
    final statusCode = await NotepadDataProvider.putNotepadData(id, body);
    return (statusCode == 200 || statusCode == 201);
  }

  Future<bool> addData(Map body) async {
    final statusCode = await NotepadDataProvider.postNotepadData(body);
    return statusCode == 201;
  }
}
