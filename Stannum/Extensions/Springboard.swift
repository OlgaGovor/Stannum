//
//  Springboard.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//

import XCTest

public class Springboard {
    
    let defaultTimeout = TimeInterval(10)
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    public init() {}
    
    public func deleteMyApp(appName: String) {
        XCTContext.runActivity(named: "Delete application \(appName)") { _ in
            XCUIApplication().terminate()
            springboard.activate()
            
            let icon = springboard.icons[appName]
            guard icon.waitForExistence(timeout: defaultTimeout) else {
                XCTFail("Application \(appName) is not exist")
                return
            }
            
            let iconFrame = icon.frame
            let springboardFrame = springboard.frame
            icon.press(forDuration: 1.3)
            
            springboard.coordinate(withNormalizedOffset: CGVector(dx: (iconFrame.minX + 3) / springboardFrame.maxX, dy: (iconFrame.minY + 3) / springboardFrame.maxY)).tap()
            
            guard springboard.alerts["Delete “\(appName)”?"].waitForExistence(timeout: defaultTimeout) else {
                XCTFail("You try to delete not \(appName)")
                return
            }
            springboard.alerts.buttons["Delete"].tap()
            XCUIDevice.shared.press(.home)
        }
    }
}

