//
//  XCUIApplicationExtension.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//

import XCTest

extension XCUIApplication {
    
    /**
     Extension to XCUIApplication
     
     Active application go to background by click on **Home** button
     */
    public func goToBackground() {
        XCTContext.runActivity(named: "Application goes to background") { _ in
            XCUIDevice.shared.press(.home);
        }
    }
    
    /**
     Extension to XCUIApplication
     
     Hard close (terminate) application
     */
    public func close() {
        XCTContext.runActivity(named: "Application hard close") { _ in
            self.terminate();
        }
    }
}
