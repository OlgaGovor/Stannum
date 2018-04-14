//
//  XCUIElementExtension.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//

import XCTest

public let defaultTimeout: TimeInterval = 3

extension XCUIElement {
    
    /// Extension to XCUIElement
    ///
    /// Returns all descendants of an element.
    public var allElements: XCUIElementQuery {
        return descendants(matching: .any)
    }
    
    /**
     Extension to XCUIElement
     
     Clear input field and then input **text** variable in it
     - Parameter text: Text to input in the element.
    */
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
    
    /**
     Extension to XCUIElement
     
     Wait while element become hittable
     - Parameter timeout: Maximum timeout to wait, **default** value is 10sec
     */
    public func waitForHittable(timeout: TimeInterval = 10) -> Bool {
        let predicate = NSPredicate(format: "hittable == 1")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
    
    /**
     Extension to XCUIElement
     
     Tap on element even if it never becomes hittable. Tap by coordinates on left upper corner of element
     */
    func forceTap(){
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(
                withNormalizedOffset: CGVectorFromString("{0.0,0.0}"))
            coordinate.tap()
        }
    }
    
    /**
     Extension to XCUIElement
     
     Swipe Up to element while it becomes in **exists** state
     */
    func scrollToExist(app: XCUIApplication) {
        while (!self.exists){
            app.swipeUp()
        }
    }
    
    /**
     Extension to XCUIElement
     
     Swipe Up to element while it becomes in **hittable** state
     */
    func scrollToHittable(app: XCUIApplication) {
        while (!self.isHittable) {
            app.swipeUp()
        }
    }
    
    /**
     Scroll direction to use in scroll methods
     
     - up: to scroll up
     - down: to scroll down
     */
    public enum ScrollDirection {
        case up //swiftlint:disable:this identifier_name
        case down
    }
    
    /**
     Extension to XCUIElement
     
     Scroll to element
     - Parameter direction: scroll direction, could be **up** or **down**
     - Parameter predicate
     - Parameter type: type of element to find
     - Parameter identifier:
     - Parameter timeout: timeout for scrolling, defualt value is 3 sec
     - Returns: XCUIElement if was found or **nil** if it was NOT found
     */
    public func scroll(direction: ScrollDirection, toFindElementPassing predicate: NSPredicate,
                       type: XCUIElement.ElementType = .any,
                       stopOnViewWithIdentifier identifier: String? = nil,
                       timeout: TimeInterval = defaultTimeout) -> XCUIElement? {
        return scroll(direction: direction, untilFound: {
            let element = $0.descendants(matching: type).matching(predicate).element
            return element.waitForHittable() ? element : nil
        }, stopWhen: {
            $0.allElements.matching(type, identifier: identifier).count > 0
        })
    }
    
    public func scroll(direction: ScrollDirection, toFindElementWith identifier: String, type: XCUIElement.ElementType = .any, timeout: TimeInterval = defaultTimeout) -> XCUIElement? {
        return scroll(direction: direction, untilFound: {
            let element = $0.descendants(matching: type)[identifier]
            return element.waitForHittable() ? element : nil
        })
    }
    
    public func scroll(direction: ScrollDirection, untilFound elementClosure: (XCUIElement) -> (XCUIElement?), stopWhen stopClosure: ((XCUIElement) -> Bool)? = nil) -> XCUIElement? {
        guard elementType == .table || elementType == .collectionView || elementType == .scrollView else {
            fatalError("XCUIElement is not scrollable.")
        }
        
        var reachedTheEnd = false
        var allVisibleElements = [String]()
        
        if let element = elementClosure(self) {
            return element
        }
        
        if stopClosure?(self) == true {
            return nil
        }
        
        let dyBegin = direction == .down ? 0.9 : 0.1
        let dyEnd = direction == .down ? 0.1 : 0.9
        
        repeat {
            // Then, we do a scroll up on the scrollview
            let startCoordinate = coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: dyBegin))
            startCoordinate.press(forDuration: 0.01, thenDragTo: coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: dyEnd)))
            if let element = elementClosure(self) {
                return element
            }
            
            if stopClosure?(self) == true {
                return nil
            }
            
            // If not: we store the list of all the elements we've got in the ScrollView
            let elements = allElements.allElementsBoundByIndex.map({$0.identifier})
            
            // Did we read then end of the ScrollView?
            // i.e: do we have the same elements visible than before scrolling?
            reachedTheEnd = (elements == allVisibleElements)
            allVisibleElements = elements
            
        } while !reachedTheEnd
        
        return nil
    }

}
