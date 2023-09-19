//
//  Stat_ionUITests.swift
//  Stat-ionUITests
//
//  Created by furkan vural on 19.08.2023.
//

import XCTest

final class Stat_ionUITests: XCTestCase {

    

    func test_appLaunchAndSelectOneStation() throws {
        let app = XCUIApplication()
        app.launch()
        
        let middleOfScreen = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))

        let screenHeight = app.windows.firstMatch.frame.size.height

        let middleOfScreenUp = middleOfScreen.withOffset(CGVector(dx: 0, dy: -screenHeight / 4))
        
        let theMarmaraPeraElement = app.otherElements["The Marmara Pera"]
        
        sleep(UInt32(1.3))
        // Step-1
        app.maps.containing(.other, identifier:"VKPointFeature").element.swipeRight(velocity: 100)
        sleep(UInt32(0.6))
        app/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"VKPointFeature").element/*[[".maps.containing(.other, identifier:\"İstanbul\").element",".maps.containing(.other, identifier:\"Yavuz Sinan Mh.\").element",".maps.containing(.other, identifier:\"Üsküdar\").element",".maps.containing(.other, identifier:\"Şahkulu Mh.\").element",".maps.containing(.other, identifier:\"Beyoğlu\").element",".maps.containing(.other, identifier:\"Beşiktaş\").element",".maps.containing(.other, identifier:\"Şişli\").element",".maps.containing(.other, identifier:\"Kağıthane\").element",".maps.containing(.other, identifier:\"Maslak\").element",".maps.containing(.other, identifier:\"Sarıyer\").element",".maps.containing(.other, identifier:\"VKPointFeature\").element"],[[[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp(velocity: 100)
        sleep(UInt32(0.6))
        
        // Step-2
        theMarmaraPeraElement.tap()
        
        // Step-3
        sleep(UInt32(0.7))
        app.buttons["More Info"].tap()
        sleep(1)
        middleOfScreenUp.tap()
        sleep(UInt32(0.4))
        XCUIApplication().buttons["Station"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Gayrettepe Taşyapı - Özgün Katlı Otopark (3.6 KM)"]/*[[".cells.staticTexts[\"Gayrettepe Taşyapı - Özgün Katlı Otopark (3.6 KM)\"]",".staticTexts[\"Gayrettepe Taşyapı - Özgün Katlı Otopark (3.6 KM)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        sleep(1)

    }

}
