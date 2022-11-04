//
//  SwiftUIProxy.swift
//  pushNotificationsDynamicIisland
//
//  Created by mac on 10/29/22.
//

import Foundation
import SwiftUI
import UIKit

@available(iOS 14.0, *)


@objc(PushNotificationsDynamicIslandManager)
class PushNotificationsDynamicIslandManager: RCTViewManager {
  private let vc = UIHostingController(rootView: ContentView())
  
  @objc func pushTestNotifications() {
    print("Clicked ✅")
    vc.rootView.props.pushTestNotifications()
  }
  
  // MARK: Props
  @objc var isDevMoodEnabled: Bool {
    set { vc.rootView.props.isDevMoodEnabled = newValue }
    get { return vc.rootView.props.isDevMoodEnabled }
  }
  
  @objc override func view() -> UIView! {
    vc.view
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

}
