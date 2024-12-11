import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class NotificationAccessToken {
  static String? _token;

  //to generate token only once for an app run
  static Future<String?> get getToken async => _token ?? await _getAccessToken();

  // to get admin bearer token
  static Future<String?> _getAccessToken() async {
    try {
      const fMessagingScope ='https://www.googleapis.com/auth/firebase.messaging';

      final client = await clientViaServiceAccount(
        // To get Admin Json File: Go to Firebase > Project Settings > Service Accounts
        // > Click on 'Generate new private key' Btn & Json file will be downloaded

        // Paste Your Generated Json File Content
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "chathub-933d5",
          "private_key_id": "a94da24e65ae2f8670d59c2652fb8d250aeb0890",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCvrhL5EQQ7GtDs\nU9QFVA8PPVRpE4gr6lZy7M6TMNsWt8WC/ON3LrbbhMmblvhilFl30scxiVenlc7u\nMSnP7SzLeaqouMS+/NtLam0wopUbXt465tjBlva0l6OG2IUg8iFRvGYLZuSlQwnL\nlY9nLx02eqX98A44HMp5Qbc2WSZfOHmfibUAAGXdB142R5ShD/nYl+0Qsm36S6Vp\nczPVuF9JwZKaffMAvZIMcOYihYiifhNd8sxfAot89VvuVQW8qtMHfym5Jz8rNXK6\nHWrcU+J0CLmBbNEikxMCNwMqehJAAes+05NDj6g+d5jtErkKbR69/uuBUM+l+yRB\nW/jB/tINAgMBAAECggEACH3VwW+y4Gd8qzunDyXfv3kTrCuLRLIkQRRUrNUq9ddm\nptzx4rghkw1BUHG06lDo3SuVQL32fG13jdhXAMuiQ2iLWPHrYp7mu6e2hOgK5IKK\no9a2Ke9R1+tPdmxfTPcfKKv+U7VCvoE1xz8gqhhjJVe6z8IrccdkewVz5V7cRbRo\nqQBz6zpRNwwoa3K6vFaMF580FTJXBguoC265d2k76Qo5fyYlCtEJDJa+q1WtkLgG\nFjOZ8/drNAE9eDrCxJ+G7HPQSDHWNGGFzBvswKqMZIjCx1Y6P8n2Wra+n/aTbREY\n3s5UmVEA/uR13cn+lDJ07Wpq1pwceqzLnFPjuvJNoQKBgQD0f3MD3Bu4wHjIPKiO\nkUXxFqUqwXme3ZZUi+gJ/m5/r0VpAVyNl3bpnGkrd9FkQhQwKEKX1ndN+DSiVp6o\ne3nG0Ha5BxBcGQwr4ODQbYnEsMmCZTvzCcHKqUA30H+AJ4b1Kvu/s1nX//jolxFZ\npAnADPPWUjJRbYhEJZ3C5KkjbQKBgQC38dVcIQaFmq2fCbYfK1ghwYpe4BaLzY5g\nUGEgvQcimMG9o+hi44/tV5SMNlfcLV9Bha3uDsRSb3umn7buH7sTNQN92PjFhAKs\nZskXFOtyjPKJl/Ut3AcncRlvthdPJkcLBCtGaLQumnccm2+sw6pVysZpDAy6FLTg\ntFxwwEylIQKBgQDFzu8gqk2LVbziU6ETZxktCmMqikl5bFEZqe9bVovTpdwELmPQ\n8j/0lOTJlDDGamem5ouqCIuRe0QqKuZF7VACt9m1rK9hs6oTPebk+hpCFb2ST5EG\n+lfdPL2F6puc9V3MsK/o0pPXm3KnysDwwzRYOqJ0PSAUnQdoCv7uFM16qQKBgHVH\nemqwH9FlapeBAJ5k618yX//Xzmg6mjFsblEKVJdJYBWCgPMz9hs0gODY8THPt/E1\nw0yKG8AXlnYJVQAEOSmo3l4JzatZXL8BFetiii/SD/2MZmVj6SfLo5UnOztaw2cR\ntGnC7kbcc19I923mnx7uF4z4gtDNzPmL5Xh6EyQhAoGBAJyedZTWe1K1x2pf0WE+\n9ukUeeyWqJnsjOf1691YG/2pqc5nMOyIibXA1X2jRpMl4d8ifb2Ys4fzwrZBCuvV\n4bcryzFZpOhTEdxBjdxg0rJkidJyf5diV5PfxhlgZYb0CkfMAbcs0MfEfwsYHNO5\nFI7jnESjn4p12CFoZdvt8uW8\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-h0z0s@chathub-933d5.iam.gserviceaccount.com",
          "client_id": "117664613372518336610",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-h0z0s%40chathub-933d5.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
          }
        ),
        [fMessagingScope],
      );

      _token = client.credentials.accessToken.data;

      return _token;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
