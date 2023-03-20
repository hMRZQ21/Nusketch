import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

// obtain the dynamic library from which we’ll access our custom C++ function.
final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open('libnative_add.so')
    : DynamicLibrary.process();

// load the function
final int Function(int x, int y) testFunction = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('testFunction')
    .asFunction();

// function call
void testPrint() {
  int output = testFunction(100, 100);
  print(output);
}
