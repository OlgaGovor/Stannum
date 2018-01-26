//
//  TestApp.swift
//  Stannum
//
//  Created by Olga Govor on 25/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//
import XCTest

open class TestApp {
    
    let app: XCUIApplication
    let bundleId: String
    
    public init(appFromTest: XCUIApplication) {
        app = appFromTest
        bundleId = ""
    }
    
    public init(appFromTest: XCUIApplication, appBundleId: String) {
        app = appFromTest
        bundleId = appBundleId
    }
    
    public func getBundleId() -> String {
        return bundleId
    }
    
    public func getApp() -> XCUIApplication {
        return app
    }
}
