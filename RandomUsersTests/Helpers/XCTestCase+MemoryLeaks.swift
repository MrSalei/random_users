//
//  XCTestCase+MemoryLeaks.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import XCTest

extension XCTestCase {
    
    func trackForMemoryLeaks(_ instanse: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instanse] in
            XCTAssertNil(instanse, "Potential memory leak", file: file, line: line)
        }
    }
}
