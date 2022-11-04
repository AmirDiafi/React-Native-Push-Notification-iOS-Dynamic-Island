//
//  ContentView.swift
//  Dynamic Island
//
//  Created by mac on 10/9/22.
//

import SwiftUI

@available(iOS 14.0, *)

struct NotificationValue: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let content: UNNotificationContent?
    let dateCreated: Date = Date()
    let showNotification: Bool = false
    let imageName: String?
}


@available(iOS 14.0, *)


struct ContentView: View {
  private let notificationManager = NotificationManager.instance
  @State var isOpen: Bool = false
  @ObservedObject var props = NotificationsPublisher.instance

    
  var body: some View {
      VStack {
          if UIApplication.shared.hasDynamicIsland {
              ZStack {
                ForEach(props.notifications) { item in
                      DynamicIslandNotification(value: item)
                          .ignoresSafeArea()
                  }
              }
          }
          
        if props.isDevMoodEnabled {
          VStack {
            Text("Dynamic Island Preview")
                .font(.title)
            
            Button(action:{
              props.pushTestNotifications()
            }) {
                Text("Push 🚨")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
                    .shadow(radius: 10)
            }
          }
          .padding()
          .background(Color.gray)
        }
      }
      .background(Color.green)
      .onAppear(perform: {
          notificationManager.authorizeNotifications()
      })
      .onReceive(
          NotificationCenter.default
          .publisher(for: NSNotification.dynamicIslandAlert))
      { obj in
          if let content = obj.userInfo?["content"] as? UNNotificationContent {
              let newNotification = NotificationValue(
                  content: content,
                  imageName: nil)
            DispatchQueue.main.async {
              props.notifications.append(newNotification)
            }
         }
      }
  }
    
}

@available(iOS 14.0, *)

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        if UIApplication.shared.hasDynamicIsland {
            // MARK: Animated custom Dynamic Screen.
            NotificationCenter.default.post(
                name: NSNotification.dynamicIslandAlert,
                object: nil,
                userInfo: [
                    "info": "Test",
                    "content": notification.request.content
                ]
            )
            return [.sound]
        } else {
            // MARK: Normal Notification.
            return [.sound, .badge]
        }
    }
}

extension UIApplication {
    var hasDynamicIsland: Bool {
        return deviceName == "iPhone 14 Pro" || deviceName == "iPhone 14 Pro Max"
    }
    var deviceName:String {
        UIDevice.current.name
    }
}


extension NSNotification {
    static let dynamicIslandAlert = Notification.Name.init("dynamicIslandAlert")
}
