//
//  String+RemoveComments.swift
//
//
//  Created by Evgeniy Zabolotniy on 04.05.2023.
//

extension String {
  public func removeComments() -> String {
    var commentStartIndex = endIndex
    for i in indices.dropFirst() {
      if self[i] == "/" && self[index(before: i)] == "/" {
        commentStartIndex = index(before: i)
        break
      }
    }

    let noCommentString = self[..<commentStartIndex]
    if let firstLetterIndex = noCommentString.firstIndex(where: { !$0.isWhitespace }),
       let lastLetterIndex = noCommentString.lastIndex(where: { !$0.isWhitespace }) {
      return String(self[firstLetterIndex...lastLetterIndex])
    }
    return ""
  }
}
