import 'package:flakka_protobuf_build/flakka_protobuf_build.dart';
import 'package:flakka_protobuf_build_types/google/protobuf/compiler/plugin.pb.dart';

/// Returns a [CodeGeneratorResponse] given a [CodeGeneratorRequest]
///
/// Called by a [BuildRequestProcessor]
typedef BuildRequestHandler = CodeGeneratorResponse Function(
  CodeGeneratorRequest request,
);
