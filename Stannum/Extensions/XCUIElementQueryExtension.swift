//
//  XCUIElementQueryExtension.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//
import XCTest

extension XCUIElementQuery {
    
    public func labelContains(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "label CONTAINS %@", text))
        return query
    }
    
    public func idContains(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "identificator CONTAINS %@", text))
        return query
    }
    
    public func textContains(text: String) -> XCUIElementQuery {
        let query = self.containing(NSPredicate(format: "text CONTAINS %@", text))
        return query
    }
}
