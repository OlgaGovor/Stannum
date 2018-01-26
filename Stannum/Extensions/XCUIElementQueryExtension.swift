//
//  XCUIElementQueryExtension.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//
import XCTest

extension XCUIElementQuery {
    
    public func byLabelContains(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "label CONTAINS %@", text))
        return query
    }
    
    public func byIdContains(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "identificator CONTAINS %@", text))
        return query
    }
    
    public func byTextContains(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "text CONTAINS %@", text))
        return query
    }
    
    public func byLabel(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "label = %@", text))
        return query
    }
    
    public func byId(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "identificator = %@", text))
        return query
    }
    
    public func byText(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "text = %@", text))
        return query
    }
}
