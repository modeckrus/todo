import 'dart:io';

String fixture(String name) => File('test/features/todo/fixtures/$name').readAsStringSync();
