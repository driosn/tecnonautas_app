import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamcontroller = StreamController<String>.broadcast();

  PushNotificationsProvider() {
    _firebaseMessaging.subscribeToTopic('all');
  }


  Stream<String> get mensajesStream => _mensajesStreamcontroller.stream;

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
    // Or do other work.
  }  

  initNotifications() async {

    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print("FCM Token:");
    print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage, 
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume
    );
  }


  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    
    // Cuando la aplicación está abierta
    print("On message");

    // final argumento = message['data']['descripcion'];
    // _mensajesStreamcontroller.sink.add(argumento);
    

  }  

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    
    // Cuando la aplicación se abre
    print("On launch");

    // final argumento = message['data']['descripcion'];
    // _mensajesStreamcontroller.sink.add(argumento);

  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    
    // Cuando se resume del background
    print("On resume");

    // final argumento = message['data']['descripcion'];
    // _mensajesStreamcontroller.sink.add(argumento);

  }  

  dispose() {
    _mensajesStreamcontroller?.close();
  }
}

// feIyukoyqjM:APA91bFJX4bqlqtILrDHjN8aSp29MNc9Tx1bnADj22m9h2oPuQDF13D4L12qVWao74EtOZrCcZ2XahAASKpGwlBIw4B7qpIwZ9viIJz775SpqvE-VSEZlCPCuJ36bKeRSGY1EEjM0NFC