import 'dart:io';
import 'dart:isolate';
import 'package:watcher/watcher.dart';
import 'package:path/path.dart' as path;

void main() async {
  final directories = [
    'dir1',
    'dir2',
  ];

  final receivePort = ReceivePort();

  receivePort.listen((message) async {
    if (message is String) {
      try {
        await File('events.log')
            .writeAsString('$message\n', mode: FileMode.append);
      } catch (e) {
        print('Ошибка записи в файл: $e');
      }
    }
  });

  for (final dir in directories) {
    await Isolate.spawn(
      _watchDirectoryIsolate,
      _IsolateData(dir, receivePort.sendPort),
    );
  }

  print('Мониторинг запущен для каталогов: $directories');
}

class _IsolateData {
  final String directory;
  final SendPort sendPort;

  _IsolateData(this.directory, this.sendPort);
}

void _watchDirectoryIsolate(_IsolateData data) async {
  final directory = Directory(data.directory);

  if (!await directory.exists()) {
    print('Каталог ${data.directory} не существует.');
    return;
  }

  final watcher = DirectoryWatcher(data.directory);
  watcher.events.listen((event) {
    final changeType = _mapChangeType(event.type);
    final fileName = path.basename(event.path);
    final timestamp = DateTime.now().toString();
    final logMessage = '$timestamp ${data.directory} $changeType $fileName';

    data.sendPort.send(logMessage);
  });
}

String _mapChangeType(ChangeType type) {
  switch (type) {
    case ChangeType.ADD:
      return 'ADD';
    case ChangeType.MODIFY:
      return 'EDIT';
    case ChangeType.REMOVE:
      return 'DELETE';
    default:
      return 'UNKNOWN';
  }
}
