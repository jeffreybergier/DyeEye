//
//  Created by Jeffrey Bergier on 2022/10/06.
//
//  MIT License
//
//  Copyright (c) 2021 Jeffrey Bergier
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import SwiftUI
import WidgetKit
import ActivityKit

public struct EyeView: Widget {
    
    public init() {}
    
    public var body: some WidgetConfiguration {
        ActivityConfiguration(for: EyeAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Text("|")
            }
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    LeadingView(wallSeconds: context.state.wallSeconds)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    TrailingView(count: context.state.count)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                }
            } compactLeading: {
                LeadingView(wallSeconds: context.state.wallSeconds)
            } compactTrailing: {
                TrailingView(count: context.state.count)
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

internal struct LeadingView: View {
    private let wallSeconds: Int
    internal init(wallSeconds: Int) {
        self.wallSeconds = wallSeconds
    }
    internal var body: some View {
        Text(String(self.wallSeconds))
            .modifier(BackgroundCircle(.blue))
    }
}

internal struct TrailingView: View {
    private let count: Int
    internal init(count: Int) {
        self.count = count
    }
    internal var body: some View {
        Text(String(self.count))
            .modifier(BackgroundCircle(.green))
    }
}

internal struct BackgroundCircle: ViewModifier {
    private let color: Color
    internal init(_ color: Color) {
        self.color = color
    }
    internal func body(content: Content) -> some View {
        ZStack {
            Circle()
                .foregroundColor(self.color)
            content
                .padding(4)
        }
    }
}
