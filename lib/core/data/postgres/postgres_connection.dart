import 'package:postgres/postgres.dart';

class PostgresConnection {
  static Connection? _conn;

  static Future<Connection> openConnection() async {
    //ip needs to be 10.0.2.2, since if we use localhost or 127.0.0.1, it would be the EMULATOR DEVICE'S ip
    _conn = await Connection.open(
        Endpoint(
          host: 'localhost',
          port: 5432,
          database: 'app_citas',
          username: 'app_citas',
          password: 'app_citas',
        ),
        settings: ConnectionSettings(sslMode: SslMode.disable));
    return _conn!;
  }

  static Future<void> closeConnection() async {
    await _conn!.close();
  }

  static Connection getConnection() => _conn!;
}
