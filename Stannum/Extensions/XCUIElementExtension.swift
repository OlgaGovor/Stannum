//
//  XCUIElementExtension.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//

import XCTest

extension XCUIElement {
    
    public func clearAndEnterText(text: String) {
        
        guard let stringValue = self.value as? String else {
            self.typeText(text)
            return
        }
        
        if stringValue.isEmpty {
            self.typeText(text)
            return
        }
        
        self.tap()
        let deleteString = stringValue.map {
            _ in XCUIKeyboardKey.delete.rawValue }.joined(separator: "") // fix
        
        self.typeText(deleteString)
        self.typeText(text)
    }
    
    public func waitForHittable(timeout: TimeInterval = 10) -> Bool {
        let predicate = NSPredicate(format: "hittable == 1")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
    
    func forceTap(){
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(
                withNormalizedOffset: CGVectorFromString("{0.0,0.0}"))
            coordinate.tap()
        }
    }
}
