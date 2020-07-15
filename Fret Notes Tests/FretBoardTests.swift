//
//  FretBoardTests.swift
//  Fret Notes Tests
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import XCTest
@testable import Fret_Notes

class FretBoardTests: XCTestCase {

    private let fretboard = FretBoard()

    func testNoteAtFretZero() {
        XCTAssertEqual(fretboard.note(on: 0, string: 1), .e)
        XCTAssertEqual(fretboard.note(on: 0, string: 2), .b)
        XCTAssertEqual(fretboard.note(on: 0, string: 3), .g)
        XCTAssertEqual(fretboard.note(on: 0, string: 4), .d)
        XCTAssertEqual(fretboard.note(on: 0, string: 5), .a)
        XCTAssertEqual(fretboard.note(on: 0, string: 6), .e)
    }


    func testNoteAtFirstFret() {
        XCTAssertEqual(fretboard.note(on: 1, string: 1), .f)
        XCTAssertEqual(fretboard.note(on: 1, string: 2), .c)
        XCTAssertEqual(fretboard.note(on: 1, string: 3), .gSharp)
        XCTAssertEqual(fretboard.note(on: 1, string: 4), .dSharp)
        XCTAssertEqual(fretboard.note(on: 1, string: 5), .aSharp)
        XCTAssertEqual(fretboard.note(on: 1, string: 6), .f)
    }


    func testNoteAtFiftFret() {
        XCTAssertEqual(fretboard.note(on: 5, string: 1), .a)
        XCTAssertEqual(fretboard.note(on: 5, string: 2), .e)
        XCTAssertEqual(fretboard.note(on: 5, string: 3), .c)
        XCTAssertEqual(fretboard.note(on: 5, string: 4), .g)
        XCTAssertEqual(fretboard.note(on: 5, string: 5), .d)
        XCTAssertEqual(fretboard.note(on: 5, string: 6), .a)
    }


    func testNoteAtSeventhFret() {
        XCTAssertEqual(fretboard.note(on: 7, string: 1), .b)
        XCTAssertEqual(fretboard.note(on: 7, string: 2), .fSharp)
        XCTAssertEqual(fretboard.note(on: 7, string: 3), .d)
        XCTAssertEqual(fretboard.note(on: 7, string: 4), .a)
        XCTAssertEqual(fretboard.note(on: 7, string: 5), .e)
        XCTAssertEqual(fretboard.note(on: 7, string: 6), .b)
    }


    func testNoteAtTwelvethFret() {
        XCTAssertEqual(fretboard.note(on: 12, string: 1), .e)
        XCTAssertEqual(fretboard.note(on: 12, string: 2), .b)
        XCTAssertEqual(fretboard.note(on: 12, string: 3), .g)
        XCTAssertEqual(fretboard.note(on: 12, string: 4), .d)
        XCTAssertEqual(fretboard.note(on: 12, string: 5), .a)
        XCTAssertEqual(fretboard.note(on: 12, string: 6), .e)
    }


    func testNoteAtTwentyFirstFret() {
        XCTAssertEqual(fretboard.note(on: 21, string: 1), .cSharp)
        XCTAssertEqual(fretboard.note(on: 21, string: 2), .gSharp)
        XCTAssertEqual(fretboard.note(on: 21, string: 3), .e)
        XCTAssertEqual(fretboard.note(on: 21, string: 4), .b)
        XCTAssertEqual(fretboard.note(on: 21, string: 5), .fSharp)
        XCTAssertEqual(fretboard.note(on: 21, string: 6), .cSharp)
    }
}
