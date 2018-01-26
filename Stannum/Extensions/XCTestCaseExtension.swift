//
//  XCTestCaseExtension.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func activateAppByBundleId(bundleId: String) {
        let app = XCUIApplication(bundleIdentifier: bundleId)
        app.activate()
    }
}
