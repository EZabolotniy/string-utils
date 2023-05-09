//
//  String+RemoveComments.swift
//
//
//  Created by Evgeniy Zabolotniy on 04.05.2023.
//

extension String {
  public func removeCommentsAndTrimWhitespaces() -> String {
    var isInsideMultilineComment = false
    return split(whereSeparator: { $0.isNewline }).map {
      String($0.removeCommentsAndTrimWhitespaces(&isInsideMultilineComment))
    }.filter { !$0.isEmpty }
      .joined(separator: "\n")
  }
}

extension StringProtocol {
  fileprivate func removeCommentsAndTrimWhitespaces(_ isInsideMultilineComment: inout Bool) -> any StringProtocol {
    guard first(where: { $0.isNewline }) == nil else {
      fatalError("This function should be called on a single line string")
    }
    return removeMultilineComment(&isInsideMultilineComment)
      .removeDoubleSlashComment()
      .trimWhitespaces()
  }
}

// MARK: - Multiline comment removal
extension StringProtocol {
  private func removeMultilineComment(_ isInsideMultilineComment: inout Bool) -> any StringProtocol {
    let commentStartIndex = startIndexOfOpenMultilineComment
    let commentEndIndex = endIndexOfClosedMultilineComment
    if isInsideMultilineComment, commentEndIndex == nil {
      return ""
    }
    if let commentStartIndex = commentStartIndex, commentEndIndex == nil {
      isInsideMultilineComment = true
      return self[..<commentStartIndex]
    }
    if commentStartIndex == nil, let commentEndIndex = commentEndIndex {
      isInsideMultilineComment = false
      return self[commentEndIndex...]
    }
    if let commentStartIndex = commentStartIndex, let commentEndIndex = commentEndIndex {
      if commentStartIndex < commentEndIndex {
        var tmp = String(self)
        tmp.replaceSubrange(commentStartIndex..<commentEndIndex, with: "")
        return tmp
      } else {
        return self[commentEndIndex..<commentStartIndex]
      }
    }
    return self
  }

  public var startIndexOfOpenMultilineComment: String.Index? {
    for i in indices.dropFirst() {
      let prevIndex = index(before: i)
      if self[prevIndex] == "/" && self[i] == "*" {
        return prevIndex
      }
    }
    return nil
  }

  public var endIndexOfClosedMultilineComment: String.Index? {
    for i in indices.dropFirst() {
      let prevIndex = index(before: i)
      if self[prevIndex] == "*" && self[i] == "/" {
        return index(after: i)
      }
    }
    return nil
  }
}

// MARK: - Double slash comment removal
extension StringProtocol {
  private func removeDoubleSlashComment() -> any StringProtocol {
    guard first(where: { $0.isNewline }) == nil else {
      fatalError("This function should be called on a single line string")
    }
    let commentStartIndex = startIndexOfDoubleSlash ?? endIndex
    return self[..<commentStartIndex]
  }

  private var startIndexOfDoubleSlash: String.Index? {
    for i in indices.dropFirst() {
      let prevIndex = index(before: i)
      if self[prevIndex] == "/" && self[i] == "/" {
        return prevIndex
      }
    }
    return nil
  }
}

// MARK: - Trimming whitespaces
extension StringProtocol {
  private func trimWhitespaces() -> any StringProtocol {
    guard first(where: { $0.isNewline }) == nil else {
      fatalError("This function should be called on a single line string")
    }
    if let firstLetterIndex = firstIndex(where: { !$0.isWhitespace }),
       let lastLetterIndex = lastIndex(where: { !$0.isWhitespace }) {
      return self[firstLetterIndex...lastLetterIndex]
    }
    return ""
  }
}
