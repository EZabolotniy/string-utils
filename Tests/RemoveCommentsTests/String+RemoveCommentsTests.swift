//
//  String+RemoveCommentsTests.swift
//
//
//  Created by Evgeniy Zabolotniy on 08.04.2023.
//

import XCTest
@testable import RemoveComments

final class StringRemoveCommentsTests: XCTestCase {
  func testEmptyLine() throws {
    let line = ""
    let removedComment = line.removeComments()
    XCTAssertEqual(removedComment, "")
  }

  func testNewLine() throws {
    let line = "\n"
    let removedComment = line.removeComments()
    XCTAssertEqual(removedComment, "")
  }

  func testWhitespacesAndNewLine() throws {
    let line = "     \n"
    let removedComment = line.removeComments()
    XCTAssertEqual(removedComment, "")
  }

  func testCommentLine() throws {
    let line = "// Comment line"
    let removedComment = line.removeComments()
    XCTAssertEqual(removedComment, "")
  }

  func testCommentLineWithSpacePrefix() throws {
    let line = "   // Comment line"
    let removedComment = line.removeComments()
    XCTAssertEqual(removedComment, "")
  }

  func testCodeWithCommentLine() throws {
    let line = "push local 1 // Comment line"
    let removedComment = line.removeComments()
    XCTAssertEqual(removedComment, "push local 1")
  }

  func testNoCommentLine() throws {
    let line = "push local 1"
    let removedComment = line.removeComments()
    XCTAssertEqual(removedComment, line)
  }
}

