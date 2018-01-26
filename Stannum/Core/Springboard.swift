//
//  Springboard.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//

import XCTest

open class Springboard {
    
    public init() {}
    
    let defaultTimeout = TimeInterval(10)
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    func searchField() -> XCUIElement {
        return springboard.searchFields["SpotlightSearchField"];
    }
    
    func searchResultApp(text: String) -> XCUIElement {
        return springboard.buttons[text]
    }
    
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
    
    public func swipeDown(){
        let start = springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let end = springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.75))
        start.press(forDuration: 0.5, thenDragTo: end)
    }
    
    public func searchAndLaunchAppFromSpotlight(appName: String) {
        XCTContext.runActivity(named: "Search and launch App \(appName) from spotlight search") { _ in
            searchInSpotlight(searchText: appName)
            guard searchResultApp(text: appName).waitForHittable() else {
                XCTFail("can't find \(appName)")
                return
            }
            searchResultApp(text: appName).tap()
        }
    }
    
    public func searchInSpotlight(searchText: String) {
        XCTContext.runActivity(named: "Search in Springboard spotlight \(searchText)") { _ in
            swipeDown()
            guard searchField().waitForHittable() else {
                XCTFail("Spotlight search is not exist")
                return;
            }
            
            searchField().clearAndEnterText(text: searchText)
        }
    }
}

