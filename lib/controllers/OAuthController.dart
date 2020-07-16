import 'dart:async';
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';
import 'package:universidaderpg/models/Token.dart';

class OAuthController extends ResourceController {
  @Operation.post()
  Future<Response> auth() async {
    return Response.ok(Token(
        expires: 3000,
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"))
      ..contentType = ContentType.json;
  }

  @override
  void documentComponents(APIDocumentContext context) {
    super.documentComponents(context);

    final personSchema = Token().documentSchema(context);
    context.schema.register("Token", personSchema, representation: Token);
  }

  @override
  Map<String, APIResponse> documentOperationResponses(
      APIDocumentContext context, Operation operation) {
    if (operation.method == "POST") {
      return {
        "200": APIResponse.schema(
            'Token Criado', context.schema.getObjectWithType(Token))
      };
    }

    return {};
  }

  @override
  Map<String, APIOperation> documentOperations(
      APIDocumentContext context, String route, APIPath path) {
    final ops = super.documentOperations(context, route, path);

    return ops;
  }
}
