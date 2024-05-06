// Interface de Controle de acesso aos Serviços
abstract class UserController {
  Future<String> saveUser(String requestBodyJSON);
  Future<String> getAllUser();
  Future<String> getUserById(int id);
  Future<String> updateUser(String requestBodyJSON);
  Future<String> deleteUser(int id);
  Future<String> validateLogin(String login, String password);
}
