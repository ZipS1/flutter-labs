import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const baseUrl = 'http://localhost:8080/records';

void main() async {
  while (true) {
    print('\nMenu:');
    print('1. View all records');
    print('2. Add a record');
    print('3. Edit a record');
    print('4. Delete a record');
    print('5. Exit');
    stdout.write('Select an option: ');

    final choice = stdin.readLineSync();
    switch (choice) {
      case '1':
        await _viewRecords();
        break;
      case '2':
        await _addRecord();
        break;
      case '3':
        await _editRecord();
        break;
      case '4':
        await _deleteRecord();
        break;
      case '5':
        exit(0);
      default:
        print('Invalid option!');
    }
  }
}

Future<void> _viewRecords() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final records = jsonDecode(response.body) as List;
      if (records.isEmpty) {
        print('No records found.');
      } else {
        records
            .forEach((record) => print('${record['id']}: ${record['record']}'));
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Connection error: $e');
  }
}

Future<void> _addRecord() async {
  stdout.write('Enter record text: ');
  final text = stdin.readLineSync()?.trim() ?? '';
  if (text.isEmpty) {
    print('Text cannot be empty!');
    return;
  }

  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'record': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Added record with ID: ${data['id']}');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> _editRecord() async {
  stdout.write('Enter record ID: ');
  final id = stdin.readLineSync()?.trim();
  if (id == null || int.tryParse(id) == null) {
    print('Invalid ID!');
    return;
  }

  stdout.write('Enter new text: ');
  final text = stdin.readLineSync()?.trim() ?? '';
  if (text.isEmpty) {
    print('Text cannot be empty!');
    return;
  }

  try {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'record': text}),
    );

    if (response.statusCode == 200) {
      print('Record updated successfully');
    } else if (response.statusCode == 404) {
      print('Record not found');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> _deleteRecord() async {
  stdout.write('Enter record ID: ');
  final id = stdin.readLineSync()?.trim();
  if (id == null || int.tryParse(id) == null) {
    print('Invalid ID!');
    return;
  }

  try {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      print('Record deleted successfully');
    } else if (response.statusCode == 404) {
      print('Record not found');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
