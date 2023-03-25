import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:dartpy/dartpy.dart';
import 'package:dartpy/dartpy_annotations.dart';
import 'package:dotenv/dotenv.dart';
import 'dart:io' show Platform, exit;

// @PyFunction(module: 'pymultiply')
// int multiply(int a, int b) => multiply(a, b);

@PyFunction(module: 'pymultiply')
Future<int> multiply(int a, int b) async => multiply(a, b);

Future<void> main(List<String> args) async {
  final dotEnv = DotEnv();
  dotEnv.load(['.env']);
  final libpythonPath = Platform.environment['LIBPYTHON_PATH'];

  if (libpythonPath == null) {
    print('LIBPYTHON_PATH environment variable not set');
    exit(1);
  }

  // pointing it to the python lib via environment variables

  final pythonPath = Platform.environment['ANACONDA_PYTHON'];
  var _libpythonPath = DynamicLibrary.open(libpythonPath);
  final dartPyC = DartPyC(_libpythonPath);
  dartPyC.Py_Initialize();
  pyStart();

  // final dartPyC = DartPyC(dylib);

  try {
    final pyModule = pyImport('pymultiply'); // imports a python module
    final pFunc = pyModule
        .getFunction('pymultiply'); // gets a function within that module
    final result =
        await pFunc([1, 2]); // calls the function and gets the result
    print(result); // Should print 3
  } on DartPyException catch (e) {
    print(e);
    pyCleanup(); // Cleans up memory
    exit(1);
  }
  pyCleanup(); // Cleans up memory
  exit(0);
}
