abstract class Failure{
  String getMessage();
}

class PostgresFailure implements Failure{
  @override
  String getMessage() {
    return "Hubo un error con la base de datos postgres";
  }
}

class JSONFailure implements Failure{
  @override
  String getMessage() {
    return "Hubo un error con los archivos JSON";
  }
}