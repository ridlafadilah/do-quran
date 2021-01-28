import 'environment.dart';

class EnvironmentProduction extends Environment {
  @override
  Map<String, dynamic> get config =>
      {'profile': 'PROD', 'locale': 'en-US', 'debug': false};

  @override
  Map<String, dynamic> get hosts => {
        'hosts': {
          'pray': {
            'host': 'https://api.pray.zone',
          },
          'openapi': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'auth': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'security': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'profile': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'master': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'file': {
            'host': 'https://dongkap-api.herokuapp.com',
          },
          'notification': {
            'host': 'https://dongkap-api.herokuapp.com',
          }
        },
      };
}
