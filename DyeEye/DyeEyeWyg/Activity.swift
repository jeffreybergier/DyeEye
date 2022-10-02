//
//  DyeEyeWygLiveActivity.swift
//  DyeEyeWyg
//
//  Created by Jeffrey Bergier on 2022/10/02.
//

import ActivityKit
import WidgetKit
import SwiftUI

public struct Attributes: ActivityAttributes {
    public var name: String
    public init(name: String) {
        self.name = name
    }
}

extension Attributes {
    public struct ContentState: Codable, Hashable {
        public var value: Int
        public init(value: Int) {
            self.value = value
        }
    }
}

struct Activity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Attributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
