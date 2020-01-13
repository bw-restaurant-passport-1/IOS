//
//  RestaurantPassportUITests.swift
//  RestaurantPassportUITests
//
//  Created by Fabiola S on 1/13/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import XCTest

class RestaurantPassportUITests: XCTestCase {
    //MARK: Properties
    var app: XCUIApplication {
        return XCUIApplication()
    }
    
    private var username: XCUIElement {
        return app.textFields["Username"]
    }
    
    private var password: XCUIElement {
        return app.secureTextFields["Secure Password"]
    }
    
    private var fullName: XCUIElement {
        return app.textFields["Firstname Lastname"]
    }
    
    private var city: XCUIElement {
        return app.textFields["Home City"]
    }
    
    private var email: XCUIElement {
        return app.textFields["YourName@YourEmail.com"]
    }
    
    private var signUpButton: XCUIElement {
        return app.buttons["Login Button"]
    }
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        let app = XCUIApplication()
        
        app.launchArguments = ["UITesting"]
        app.launch()
    }
    
    //MARK: Tests
    func testSignUpSegmentedControl() {
        XCTAssertTrue(app.segmentedControls.buttons.element(boundBy: 0).isSelected)
    }
    
    func testLabelsExist() {
        XCTAssertTrue(app.staticTexts["Username"].exists)
        XCTAssertTrue(app.staticTexts["Secure Password"].exists)
        XCTAssertTrue(app.staticTexts["Firstname Lastname"].exists)
        XCTAssertTrue(app.staticTexts["Home City"].exists)
        XCTAssertTrue(app.staticTexts["YourName@YourEmail.com"].exists)
    }
    
    func testTextfieldsExist() {
        XCTAssertTrue(app.textFields["Username"].exists)
    }
    
    func testSignUpButton() {
        XCTAssertTrue(app.buttons["Sign Up"].exists)
    }
    
    func testCreateUser() {
        username.tap()
        username.typeText("UITesting")
        
        password.doubleTap()
        password.typeText("testing")
        
        fullName.doubleTap()
        fullName.typeText("UI Testing")
        
        city.doubleTap()
        city.typeText("Chicago")
        
        email.doubleTap()
        email.typeText("uitest@uitesting.com")
       
        app.keyboards.buttons["Return"].tap()
        
        app.staticTexts["Sign Up"].tap()
    }
    
    func testLoginSegmentedcontrol() {
        app.segmentedControls.buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.segmentedControls.buttons.element(boundBy: 1).isSelected)
    }
    
    func testLoginLabels() {
        
    }
    
    func testLoginTextFields() {
        
    }
    
    func testLoginButton() {
        
    }
    
    func testLogin() {
        
    }
}

