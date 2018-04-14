//
//  StringExtension.swift
//  Stannum
//
//  Created by Olga Govor on 24/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//

extension String {
    
    /**
     Extension to XCUIApplication
     
     Generate random string that consist onle latin latters in upper and lower case
     -Parameters length: length of Random string
     */
    public func random(strLength length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let len = UInt32(letters.length)
        
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    /**
     Extension to XCUIApplication
     
     Convert string to Bool:
     
     - Returns: boolean false/true
     
     - true: True, true, yes, 1
     
     - false: False, false, no, 0
     */
    public func toBool() -> Bool? {
        switch self {
            case "True", "true", "yes", "1": return true
            case "False", "false", "no", "0": return false
            default: return nil
        }
    }
}
