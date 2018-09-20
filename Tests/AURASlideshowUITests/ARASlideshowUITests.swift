//
//  SlideshowTextContainerViewController
//
//  This file is part of the AURASlideshow project.
//  Copyright (c) 2018 - present Alexis Aubry authors.
//
//  Licensed under the terms of the MIT License.
//

import XCTest

class AURASlideshowUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testThatItDisplaysTheSlideshow() {
        // WHEN
        app.buttons["Open Slideshow"].tap()

        // THEN
        XCTAssertTrue(app.navigationBars["Colors"].exists)

        let descriptionText = app.staticTexts["aura_slideshow.description_text"]
        XCTAssertTrue(descriptionText.exists)
        XCTAssertEqual(descriptionText.label, "Red")
    }

    func testThatItDismissesTheSlideshow() {
        // GIVEN
        app.buttons["Open Slideshow"].tap()

        // WHEN
        let doneButton = app.navigationBars["Colors"].buttons["Done"]
        doneButton.tap()

        // THEN
        XCTAssertTrue(app.buttons["Open Slideshow"].exists)
        XCTAssertTrue(app.navigationBars.count == 0)
    }

    func testThatItSwipesThroughItemsInForwardDirection() {
        // GIVEN
        app.buttons["Open Slideshow"].tap()
        let pageController = app.otherElements["aura_slideshow.page_controller"]
        let descriptionText = app.staticTexts["aura_slideshow.description_text"]

        // WHEN
        XCTAssertEqual(descriptionText.label, "Red")

        pageController.swipeLeft()
        XCTAssertEqual(descriptionText.label, "Orange")

        pageController.swipeLeft()
        XCTAssertEqual(descriptionText.label, "Yellow")

        pageController.swipeLeft()
        XCTAssertEqual(descriptionText.label, "Green")

        pageController.swipeLeft()
        XCTAssertEqual(descriptionText.label, "Blue")

        pageController.swipeLeft()
        XCTAssertEqual(descriptionText.label, "Purple")

        // Test that last item stays on screen after left swipe
        pageController.swipeLeft()
        XCTAssertEqual(descriptionText.label, "Purple")
    }

    func testThatItSwipesThroughItemsInBackwardsDirection() {
        // GIVEN
        app.buttons["Open Slideshow"].tap()
        let pageController = app.otherElements["aura_slideshow.page_controller"]
        let descriptionText = app.staticTexts["aura_slideshow.description_text"]

        // WHEN
        pageController.swipeLeft() // orange
        pageController.swipeLeft() // yellow
        pageController.swipeLeft() // green
        pageController.swipeLeft() // blue
        pageController.swipeLeft() // purple
        XCTAssertEqual(descriptionText.label, "Purple")

        pageController.swipeRight()
        XCTAssertEqual(descriptionText.label, "Blue")

        pageController.swipeRight()
        XCTAssertEqual(descriptionText.label, "Green")

        pageController.swipeRight()
        XCTAssertEqual(descriptionText.label, "Yellow")

        pageController.swipeRight()
        XCTAssertEqual(descriptionText.label, "Orange")

        pageController.swipeRight()
        XCTAssertEqual(descriptionText.label, "Red")

        // Test that first item stays on screen after right swipe
        pageController.swipeRight()
        XCTAssertEqual(descriptionText.label, "Red")
    }

}
