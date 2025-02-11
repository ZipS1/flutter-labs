import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:sqlite3/sqlite3.dart';

final db = sqlite3.open('notes.db');

void initDatabase() {
  db.execute('''
    CREATE TABLE IF NOT EXISTS records (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      record TEXT NOT NULL
    )
  ''');
}

Response _handleError(dynamic error) {
  return Response.internalServerError(
    body: jsonEncode({'error': error.toString()}),
    headers: {'Content-Type': 'application/json'},
  );
}

Response getRecords(Request request) {
  try {
    final result = db.select('SELECT id, record FROM records');
    final records = result
        .map((row) => {'id': row['id'], 'record': row['record']})
        .toList();
    return Response.ok(
      jsonEncode(records),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return _handleError(e);
  }
}

Future<Response> addRecord(Request request) async {
  try {
    final body = await request.readAsString();
    final data = jsonDecode(body) as Map;
    final record = data['record'] as String;

    db.execute('INSERT INTO records (record) VALUES (?)', [record]);
    final id = db.lastInsertRowId;

    return Response.ok(
      jsonEncode({'id': id}),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return _handleError(e);
  }
}

Future<Response> updateRecord(Request request, String idParam) async {
  try {
    final id = int.tryParse(idParam);
    if (id == null) return Response.badRequest(body: 'Invalid ID');

    final body = await request.readAsString();
    final data = jsonDecode(body) as Map;
    final newRecord = data['record'] as String;

    final result = db.select('SELECT id FROM records WHERE id = ?', [id]);
    if (result.isEmpty) return Response.notFound('Record not found');

    db.execute('UPDATE records SET record = ? WHERE id = ?', [newRecord, id]);
    return Response.ok(jsonEncode({'id': id, 'record': newRecord}));
  } catch (e) {
    return _handleError(e);
  }
}

Response deleteRecord(Request request, String idParam) {
  try {
    final id = int.tryParse(idParam);
    if (id == null) return Response.badRequest(body: 'Invalid ID');

    final result = db.select('SELECT id FROM records WHERE id = ?', [id]);
    if (result.isEmpty) return Response.notFound('Record not found');

    db.execute('DELETE FROM records WHERE id = ?', [id]);
    return Response.ok(jsonEncode({'deleted': id}));
  } catch (e) {
    return _handleError(e);
  }
}

void main() {
  initDatabase();

  final router = Router()
    ..get('/records', getRecords)
    ..post('/records', addRecord)
    ..put('/records/<id>', updateRecord)
    ..delete('/records/<id>', deleteRecord);

  io.serve(router, 'localhost', 8080).then((server) {
    print('Server running on port ${server.port}');
  });
}
