import 'dart:async';
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';
import 'package:universidaderpg/models/Classe.dart';
import 'package:universidaderpg/models/Perfil.dart';
import 'package:universidaderpg/models/PerfisPool.dart';

class PerfilController extends ResourceController {
  @Operation.get()
  Future<Response> getAll() async {
    print(PerfisPool.to);
    return Response.ok(PerfisPool.to)..contentType = ContentType.json;
  }

  @Operation.get('idReferencia')
  Future<Response> exists(@Bind.path('idReferencia') int idReferencia) async {
    for (var perfil in PerfisPool.to) {
      if (perfil.idReferencia == idReferencia) {
        return Response.ok(perfil)..contentType = ContentType.json;
      }
    }

    return Response.notFound();
  }

  @Operation.post()
  Future<Response> create(@Bind.body() Perfil perfil) async {
    for (var x in PerfisPool.to) {
      if (x.idReferencia == perfil.idReferencia) {
        return Response.ok(x)..contentType = ContentType.json;
      }
    }

    perfil.id = PerfisPool.to.length + 1;
    perfil.classe = Classe.random();
    PerfisPool.to.add(perfil);

    return Response.ok(perfil)..contentType = ContentType.json;
  }

  @override
  void documentComponents(APIDocumentContext context) {
    super.documentComponents(context);

    final personSchema = Perfil().documentSchema(context);
    context.schema.register("Perfil", personSchema, representation: Perfil);
  }

  @override
  Map<String, APIResponse> documentOperationResponses(
      APIDocumentContext context, Operation operation) {
    if (operation.method == "GET") {
      if (operation.pathVariables.isNotEmpty) {
        return {
          "200": APIResponse.schema(
              'Todos os Perfis', context.schema.getObjectWithType(Perfil)),
          "404": APIResponse.schema("Perfil não encontrado", null)
        };
      }

      return {
        "200": APIResponse.schema(
            'Perfil Encontrado',
            APISchemaObject.array(
                ofSchema: context.schema.getObjectWithType(Perfil))),
      };
    }

    if (operation.method == "POST") {
      return {
        "200": APIResponse.schema(
            'Perfil Criado', context.schema.getObjectWithType(Perfil))
      };
    }

    return {};
  }

  @override
  Map<String, APIOperation> documentOperations(
      APIDocumentContext context, String route, APIPath path) {
    final ops = super.documentOperations(context, route, path);

    // ops has been filled out by an endpoint controller,
    // add 'key' query parameter to each operation.
    ops.forEach((method, op) {
      op.addParameter(APIParameter.header("Authorization",
          description: 'Token de Autorização',
          schema: APISchemaObject.string()));
    });
    return ops;
  }
}
