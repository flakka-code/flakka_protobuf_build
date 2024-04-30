// ignore_for_file: prefer_const_constructors
import 'dart:async';
// import 'dart:typed_data' show BytesBuilder;

import 'package:flakka_internal_protobuf_types/google/protobuf/compiler/plugin.pb.dart';
import 'package:flakka_internal_protobuf_types/google/protobuf/descriptor.pb.dart';
import 'package:flakka_protobuf_build/flakka_protobuf_build.dart';
import 'package:test/test.dart';

void main() {
  group('CodeGenRequestProcessor', () {
    test('handles request and generates response', () async {
      // Create a request with some dummy data
      final request = CodeGeneratorRequest()
        ..protoFile.add(FileDescriptorProto()..name = 'test.proto')
        ..fileToGenerate.add('test.proto');

      // Create input stream
      final inputStream = Stream.fromIterable([request.writeToBuffer()]);

      // Create output stream
      final outputStreamController = StreamController<List<int>>();

      // Create the processor and handle the request
      final processorComplete =
          CodeGenRequestProcessor(inputStream, outputStreamController)
              .handle((req) {
        // Verify the request
        expect(req.protoFile.length, 1);
        expect(req.protoFile.first.name, 'test.proto');
        expect(req.fileToGenerate.length, 1);
        expect(req.fileToGenerate.first, 'test.proto');

        // Create a response
        return CodeGeneratorResponse()
          ..file.add(CodeGeneratorResponse_File()..name = 'test.pb.dart');
      });

      // Capture the response
      final outputData = await outputStreamController.stream.toList();

      // await the pending response
      await processorComplete;

      final responseBytes = outputData.expand((list) => list).toList();
      final response = CodeGeneratorResponse.fromBuffer(responseBytes);

      expect(response.file.length, 1);
      expect(response.file.first.name, 'test.pb.dart');
    });
  });
}
