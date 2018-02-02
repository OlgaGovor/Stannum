//
//  SettingsUtils.swift
//  Stannum
//
//  Created by Olga Govor on 26/01/2018.
//  Copyright © 2018 Olga Govor. All rights reserved.
//
import XCTest

open class SettingsUtils {
    
    public init() {}
    
    public func switchWiFi(isTurnedOn: Bool) {
        let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settings.activate()
        
        XCTContext.runActivity(named: "turn wifi on: \(isTurnedOn)") { _ in
            let wifi = settings.tables.staticTexts["Wi-Fi"];
            guard wifi.waitForHittable() else {
                XCTFail("Wi-fi isn't hittable")
                return
            }
            wifi.tap()
            let wifiSwitch = settings.tables.switches["Wi-Fi"]
            let wifiValue = wifiSwitch.value as! String
            if !(wifiValue.toBool() == isTurnedOn) {
                wifiSwitch.tap()
            }
            settings.terminate()
        }
    }
}
