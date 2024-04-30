import 'package:flakka_internal_protobuf_types/google/protobuf/compiler/plugin.pb.dart';
import 'package:flakka_protobuf_build/flakka_protobuf_build.dart';

/// Returns a [CodeGeneratorResponse] given a [CodeGeneratorRequest]
///
/// Called by a [BuildRequestProcessor]
typedef BuildRequestHandler = CodeGeneratorResponse Function(
  CodeGeneratorRequest request,
);
