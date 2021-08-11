//
//  CalculatorAppTests.swift
//  FunctionList_SwiftTests
//
//  Created by leeyeon2 on 2021/08/11.
//

import XCTest
@testable import FunctionList_Swift

class CalculatorAppTests: XCTestCase {
    var cal: Calculator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        cal = Calculator()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testAdd() {
        let result = cal.add(1, 2)
        XCTAssertEqual(result, 1+2)
    }
    
    func testSubtract() {
        let result = cal.subtract(1, 2)
        XCTAssertEqual(result, 1-2)
    }

}
