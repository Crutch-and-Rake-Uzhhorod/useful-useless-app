import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
    
override init() {
    super.init()
    FirebaseApp.configure()
  }

override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyATP1YIjloffQtD066MyMfPZLdE108cWD0")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
