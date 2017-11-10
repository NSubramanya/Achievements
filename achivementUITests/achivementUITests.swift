//
//  achivementUITests.swift
//  achivementUITests
//
//  Created by subramanya on 07/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import XCTest

class achivementUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        //XCUIApplication().launch()
        //app.launchArguments.append("--uitesting")
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFinalVCNavigation() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.launch()
        
        app.tables.cells.firstMatch.tap()
        app.tables.cells.firstMatch.tap()
        app.tables.cells.firstMatch.tap()
        
        //let firstcell = app.tableRows.firstMatch
        
        XCTAssert(app.staticTexts["Name"].exists)
    }
    
    func testFullNavigation() {
        app.launch()
        
        app.tables.cells.firstMatch.tap()
        //app.tableRows.firstMatch.tap()
        app.tables.cells.firstMatch.tap()
        app.tables.cells.firstMatch.tap()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        XCTAssert(userInFirstVC())
    }
    
    func userInFirstVC() -> Bool {
        let titleText = app.navigationBars.element.identifier
        if titleText == "Groups" {
            return true
        } else {
            return false
        }
    }
    
}

