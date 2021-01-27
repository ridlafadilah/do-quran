class SecurityConfig {
  Map<String, dynamic> get securityResourceModel => {
        'client_id': 'do-mobile',
        'client_secret': 'secretdo02',
        'grant_type': 'password',
        'private_key': 'UHU3NG42QjNuNHI=',
        'aes_key': 'UHVsYW5nQjNuNHI=',
        'session_idle': 5,
        'session_timeout': 10,
        'signature': true,
        'vapid': '''
BB3fvY674t6pB9TjZONmYxxlebCmSskbf8lvRLTMYHE-zZ7FONNXOCPv4ndOa1FDov10k26UXZl6rQ7nT9sxWwc''',
        'recaptcha': '6LdQB9YZAAAAAI12Oyn9yoi5BoW0Bivxo8vJl8rd',
      };

  Map<String, dynamic> get signatureHeader => {
        'authorization': 'Authorization',
        'signature': 'X-DONGKAP-Signature',
        'timestamp': 'X-DONGKAP-Timestamp',
        'key': 'X-DONGKAP-Key',
        'mark': 'X-DONGKAP-Mark',
      };

  Map<String, dynamic> get google => {
        'client_id': '''
635923857962-co20kj5j0df4etlinb9m8b8bcad1h3m5.apps.googleusercontent.com''',
      };

  Map<String, dynamic> get config => {
        'security_resource': securityResourceModel,
        'signature_header': signatureHeader,
        'google': google,
      };
}
