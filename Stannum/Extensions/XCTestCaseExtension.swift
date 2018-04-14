//
//  XCTestCaseExtension.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    /**
     Extension to XCTestCase
     
     Activate/launch an application with specific bundle identificator
     
     - Parameter bundleId: bundle identificator of an application to launch
     */
    func activateAppByBundleId(bundleId: String) {
        let app = XCUIApplication(bundleIdentifier: bundleId)
        app.activate()
    }
}
