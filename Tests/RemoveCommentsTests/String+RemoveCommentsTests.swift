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
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "")
  }

  func testNewLine() throws {
    let line = "\n"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "")
  }

  func testWhitespacesAndNewLine() throws {
    let line = "     \n"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "")
  }

  func testCommentLine() throws {
    let line = "// Comment line"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "")
  }

  func testCommentLineWithSpacePrefix() throws {
    let line = "   // Comment line"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "")
  }

  func testCodeWithCommentLine() throws {
    let line = "push local 1 // Comment line"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "push local 1")
  }

  func testOpenClosedCommentLine() throws {
    let line = "/* Comment line */"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "")
  }

  func testOpenClosedCommentLineWithSpacePrefix() throws {
    let line = "   /* Comment line*/"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "")
  }

  func testLeadingCodeWithOpenClosedCommentLine() throws {
    let line = "push local 1 /* Comment line    */"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "push local 1")
  }

  func testTrailingCodeWithOpenClosedCommentLine() throws {
    let line = " /* Comment line    */ push local 1"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "push local 1")
  }

  func testCodeWithOpenClosedCommentLine() throws {
    let line = " push /* Comment line    */ local 1"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "push  local 1")
  }

  func testCodeWithOpenMultilineComment() throws {
    let line = " push local 1 /* Comment line "
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "push local 1")
  }

  func testCodeWithClosedMultilineComment() throws {
    let line = " Comment line */ push local 1"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "push local 1")
  }

  func testCodeWithClosedOpenMultilineComment() throws {
    let line = " Comment line    */ push local 1 /* Comment line "
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "push local 1")
  }

  func testCodeWithMultilineComment() throws {
    let line = """
    /*
      Multi
      Line
      Comment
    */
    push local 1
    /* one more
    multi comment */

    """
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, "push local 1")
  }

  func testCodeWithMultilineComment1() throws {
    let line = """
    /*
      Multi
      Line
      Comment
    */ push local 1 /* one more
    multi comment */
    push local 2

    """
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(
      removedComment,
      """
      push local 1
      push local 2
      """
    )
  }

  func testNoCommentLine() throws {
    let line = "push local 1"
    let removedComment = line.removeCommentsAndTrimWhitespaces()
    XCTAssertEqual(removedComment, line)
  }
}

