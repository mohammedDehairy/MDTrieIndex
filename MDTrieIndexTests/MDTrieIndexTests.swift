//
//  MDTrieIndexTests.swift
//  MDTrieIndexTests
//
//  Created by mohamed mohamed El Dehairy on 12/21/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import XCTest
@testable import MDTrieIndex

class MDTrieIndexTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTraining() {
        let trainingList = ["I am Mohamed","I am Khaled"]
        let trieIndex = MDTrieIndex(trainList: trainingList)
        NSLog("%@", trieIndex.printTrie(indentation: 0))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
