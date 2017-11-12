//
//  ModelTests.swift
//  AchievementTests
//
//  Created by sukhjeet singh sandhu on 12/11/17.
//  Copyright © 2017 sukhjeet singh sandhu. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Achievement

class ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGroup() {
        let json = JSON([
            "description" : "Achievements related to the Fractals of the Mists.",
            "name" : "Fractals of the Mists",
            "id" : "4E6A6CE7-B131-40BB-81A3-235CDBACDAA9",
            "categories" : [
                148,
                170,
                30
            ],
            "order" : 9
            ])
        let group = Group(from: json)
        
        XCTAssertTrue(group?.name == "Fractals of the Mists")
        XCTAssertTrue(group?.description == "Achievements related to the Fractals of the Mists.")
        XCTAssertTrue(group!.categories == [
            148,
            170,
            30
            ])
        XCTAssertTrue(group?.order == 9)
    }

    func testCategory() {
        let json = JSON([
            "description" : "",
            "name" : "Nightmare Fractal",
            "id" : 148,
            "achievements" : [
                3209,
                3205,
                3199,
                3236,
                3243,
                3218,
                3208,
                3211,
                3180
            ],
            "order" : 0
            ])
        let category = Category(from: json)

        XCTAssertTrue(category?.name == "Nightmare Fractal")
        XCTAssertTrue(category?.order == 0)
        XCTAssertTrue(category!.achievements == [
            3209,
            3205,
            3199,
            3236,
            3243,
            3218,
            3208,
            3211,
            3180
            ])
    }

    func testAchievement() {
        let json = JSON([
            "name" : "Nightmare Fractal",
            "id" : 3209,
            "rewards" : [
                [
                    "type" : "Item",
                    "id" : 79891,
                    "count" : 1
                ],
                [
                    "type" : "Mastery",
                    "region" : "Tyria",
                    "id" : 306
                ]
            ],
            "description" : "A sinister force lurks deep within the Mists...",
            "requirement" : "Complete all the achievements associated with the Nightmare fractal.",
            "tiers" : [
                [
                    "count" : 7,
                    "points" : 5
                ]
            ],
            "type" : "Default",
            "flags" : [
                "RepairOnLogin",
                "CategoryDisplay",
                "Permanent"
            ],
            "locked_text" : ""
            ])
        let achievement = Achievement(from: json)

        XCTAssertTrue(achievement?.name == "Nightmare Fractal")
        XCTAssertTrue(achievement?.description == "A sinister force lurks deep within the Mists...")
    }
}
