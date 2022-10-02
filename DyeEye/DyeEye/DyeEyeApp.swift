//
//  DyeEyeApp.swift
//  DyeEye
//
//  Created by Jeffrey Bergier on 2022/10/02.
//

import SwiftUI
import ActivityKit
import WygShared

@main
internal struct DyeEyeApp: App {
    
    @State internal var activity: Activity<Attributes>?
    
    internal var body: some Scene {
        WindowGroup {
            Text("Hello World")
                .onAppear() {
                    let initialContentState = Attributes.ContentState(value: 5)
                    let activityAttributes = Attributes(name: "Goodbye World")
                    do {
                        self.activity = try Activity.request(attributes: activityAttributes, contentState: initialContentState)
                    } catch (let error) {
                        print("Error requesting pizza delivery Live Activity \(error.localizedDescription).")
                    }
                }
        }
    }
}
