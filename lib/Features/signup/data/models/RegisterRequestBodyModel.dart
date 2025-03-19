import '../../domain/entities/register_request_body.dart';

class RegisterRequestBodyModel extends RegisterRequestBody {
  RegisterRequestBodyModel(
      {
        required super.email,
        required super.password,
        required super.name,

      });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,

  };
}
