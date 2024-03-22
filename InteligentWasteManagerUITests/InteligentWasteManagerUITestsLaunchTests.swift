//
//  InteligentWasteManagerUITestsLaunchTests.swift
//  InteligentWasteManagerUITests
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-02-22.
//

import XCTest

final class InteligentWasteManagerUITestsLaunchTests: XCTestCase {

    var app: XCUIApplication!
       
       override func setUpWithError() throws {
           continueAfterFailure = false
           app = XCUIApplication()
           app.launch()
           // Navigate or set the app state to show the SplashScreenView if it's not the initial view
       }
       
       func testSplashScreenElementsExist() throws {
           // Ensure the splash screen text elements are present
           XCTAssert(app.staticTexts["Sort Smart"].exists, "Sort Smart text does not exist.")
           XCTAssert(app.staticTexts["Live Green:"].exists, "Live Green: text does not exist.")
           XCTAssert(app.staticTexts["A Cleaner Tomorrow"].exists, "A Cleaner Tomorrow text does not exist.")
           XCTAssert(app.staticTexts["Start Today"].exists, "Start Today text does not exist.")
           
           // Check for the existence of the green rounded rectangle, this might be trickier as it may not have an accessibility identifier
           // This step might require adding accessibility identifiers to your views for better testability
       }
       
       func testSplashScreenTransitionAfterDelay() throws {
           // This test is to check if the isActive binding changes after the delay
           // Directly testing this behavior might be challenging without modifying the SplashScreenView to be more testable
           
           // One approach could be to wait for the expected time and then check if the UI has changed in a way that indicates the transition occurred
           // Note: This kind of test can be flaky and is generally not recommended without careful consideration
           
           let expectation = XCTestExpectation(description: "Wait for splash screen to transition")
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { // Slightly more than 3 seconds to account for any delays
               // Perform checks here to see if the transition has occurred
               // This might involve checking if the next view's elements are visible or if the splash screen's elements are no longer present
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 4.0)
       }
    
    
    
}
