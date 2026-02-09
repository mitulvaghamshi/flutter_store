import 'dart:io';

// Global strings to hold the generated content
final _nameList = [];
final _pubList = ['\n  # afonts_app:\n', '  fonts:\n'];

void main() async {
  stdout.writeln('Generating font list...');

  await _generateFontList();
  await Future.wait([_checkMain(), _updatePubspec()]);
}

Future<void> _generateFontList() async {
  final assetsDir = Directory('client/assets/afonts_app');
  if (await assetsDir.exists()) return _visit(assetsDir);
  stderr.writeln("Error: '${assetsDir.path}' directory not found.");
}

Future<void> _checkMain() async {
  final mainFile = File('client/lib/afonts_app/main.dart');
  if (!await mainFile.exists()) {
    stderr.writeln("Error: '${mainFile.path}' not found.");
    return;
  }

  final content = await mainFile.readAsString();
  if (content.contains(RegExp(r'const\s*fonts\s*=\s*\['))) {
    stderr.writeln("'${mainFile.path}' already contains fonts, skipping...");
    return;
  }

  final sink = mainFile.openWrite(mode: .append);
  sink.writeln('const fonts = [${_nameList.join(',')}];');
  await sink.close();
  stdout.writeln("Updated '${mainFile.path}'.");
}

Future<void> _updatePubspec() async {
  final pubspecFile = File('client/pubspec.yaml');
  if (!await pubspecFile.exists()) {
    stderr.writeln("Error: '${pubspecFile.path}' not found.");
    return;
  }

  final content = await pubspecFile.readAsString();
  if (content.contains(RegExp(r'fonts:\s*'))) {
    stderr.writeln("'${pubspecFile.path}' already contains fonts, skipping...");
    return;
  }

  final sink = pubspecFile.openWrite(mode: .append);
  sink.writeAll(_pubList);
  await sink.close();
  stdout.writeln("Updated '${pubspecFile.path}'.");
}

Future<void> _visit(FileSystemEntity entity) async {
  if (entity is Directory) {
    try {
      final children = await entity.list().toList();
      children.sort((a, b) => a.path.compareTo(b.path));
      await Future.forEach(children, _visit);
    } catch (e) {
      stderr.writeln('Error listing directory ${entity.path}: $e');
    }
  } else if (entity is File) {
    _process(entity);
  }
}

void _process(File file) {
  // Get filename and name (without extension)
  final path = file.uri.pathSegments.skip(1); // truncate 'client/' directory
  final name = path.last.contains('.')
      ? path.last.substring(0, path.last.lastIndexOf('.'))
      : path.last;

  _nameList.add("'$name'");
  _pubList.add('''
    - family: $name
      fonts:
        - asset: ${path.join(Platform.pathSeparator)}
''');
}
