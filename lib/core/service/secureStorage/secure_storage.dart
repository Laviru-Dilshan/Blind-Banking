import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
   final storage = new FlutterSecureStorage();

   Future<void> saveCredentials (String email, String password) async{
    try {
      await storage.write(key: "email", value: email);
      await storage.write(key: "password", value: password);
      print("email and password save in secure storage");
    }
    catch (e){
      print("failed to save");
    }
   }

    Future<String> getMail () async {
      try {
        final email = await storage.read(key: "email");
        if (email != null) {
          return email;
        } else {
          print("No email found in storage");
          return "failed to get email";
        }
      } catch (e) {
        print("Failed to read email from storage: $e");
        return "failed to get email";
      }
    }


     Future<String> getPass () async {
      try {
        final password = await storage.read(key: "password");
        if (password != null) {
          return password;
        } else {
          print("No password found in storage");
          return "failed to get password";
        }
      } catch (e) {
        print("Failed to read password from storage: $e");
        return "failed to get password";
      }
    }

}