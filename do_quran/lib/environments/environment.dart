class Environment {
  Map<String, dynamic> get config =>
      {'profile': 'DEV', 'locale': 'en-US', 'debug': true};

  Map<String, dynamic> get hosts => {
        'hosts': {
          'openapi': {
            'host': 'http://192.168.1.100:8085',
          },
          'auth': {
            'host': 'http://192.168.1.100:8085',
          },
          'security': {
            'host': 'http://192.168.1.100:8085',
          },
          'profile': {
            'host': 'http://192.168.1.100:8085',
          },
          'master': {
            'host': 'http://192.168.1.100:8085',
          },
          'file': {
            'host': 'http://192.168.1.100:8085',
          },
          'notification': {
            'host': 'http://192.168.1.100:8085',
          }
        }
      };
}
