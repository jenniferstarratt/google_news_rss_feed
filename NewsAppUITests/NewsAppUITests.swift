//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Jennifer Graham on 2/1/16.
//  Copyright © 2016 Jennifer Graham. All rights reserved.
//

import XCTest

/// General UI tests for the Google News RSS feed app.
// TODO: Create UI tests
class NewsAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
