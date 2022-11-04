//
//  userAuthorization.swift
//  Dynamic Island
//
//  Created by Amir on 10/9/22.
//

import Foundation
import SwiftUI
import Combine

func fireNotification() -> NotificationValue {
    let newNotification = NotificationValue(
        content: nil,
        imageName: nil)
    return newNotification
}

class NotificationsPublisher: ObservableObject {
  // notifications states
  @Published var notifications: [NotificationValue] = []
  // is in develoment mood [default: true]
  @Published var isDevMoodEnabled: Bool = true
  var cancellableBag = Set<AnyCancellable>()
  static let instance = NotificationsPublisher()
  
  func pushTestNotifications () {
    print("FIRED ✅")
    DispatchQueue.main.async { [weak self] in
      self?.notifications.append(fireNotification())
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { [weak self] in
      if let index = self?.notifications.firstIndex(of: fireNotification()) {
            print("remove index \(index)")
            self?.notifications.remove(at: index)
        }
    }
  }
}

@available(iOS 14.0, *)

struct NotificationManager {
    // MARK: Linking App Delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let notificationId = UUID().uuidString
    private let center = UNUserNotificationCenter.current()
    static let instance = NotificationManager()
    // MARK: Notifications request.
    func authorizeNotifications() {
        let options: UNAuthorizationOptions =  [.alert, .badge, .sound]
        center.requestAuthorization(
                options:options) {
                isAuth, error in
                    guard error == nil else {
                        return print("ERROR => \(error.debugDescription)")
                    }
                    print("Authed => \(isAuth.description)")
            }
    }
    
    func schedualNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hey from Dynamic Iceland!"
        content.subtitle = "This was so coooool!"
        content.sound = .default
        content.badge = 1
        
        let timeTriger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5.0,
            repeats: false)
        
        let request = UNNotificationRequest(
            identifier: notificationId,
            content: content,
            trigger: timeTriger)
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                center.add(request) { error in
                    print("ERROR \(error.debugDescription)")
                }
                print("FIRED 🚀")
            } else {
                authorizeNotifications()
            }
        }
        
    }
}
