//
//  Created by Jeffrey Bergier on 2022/10/05.
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
import Umbrella

@propertyWrapper
internal struct Storage: DynamicProperty {
    
    
    static private let parentDir: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.saturdayapps.DyeEye")!
    static private let plistURL: URL = Storage.parentDir.appending(component: "datastore.plist")
    
    internal typealias Value = EyeAttributes.ContentState
    
    @JSBCodableFileStorage<Value>(url: Storage.plistURL,
                                  onError: { NSLog(String(describing: $0)) })
                                  private var storage: Value?
    
    internal init() {}
    
    internal var wrappedValue: Value {
        get { self.storage ?? Value() }
        nonmutating set { self.storage = newValue }
    }
    
    internal var projectedValue: Binding<Value> {
        Binding {
            self.wrappedValue
        } set: {
            self.wrappedValue = $0
        }
    }
}

@propertyWrapper
internal struct Seconds: DynamicProperty {
    
    @StateObject private var ticker = SecondsTicker()
    
    internal var wrappedValue: Int {
        self.ticker.seconds
    }
    
    internal class SecondsTicker: ObservableObject {
        @Published internal var seconds: Int
        private var timer: Timer?
        internal init() {
            self.seconds = Calendar.current.component(.second, from: Date())
            self.timer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(self.timerFired(_:)),
                                              userInfo: nil,
                                              repeats: true)
        }
        @objc internal func timerFired(_ timer: Timer?) {
            self.seconds = Calendar.current.component(.second, from: Date())
        }
        deinit {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
}
