//
//  Restriction.swift
//  Restriction
//
//  Created by Richard Meitzler on 7/29/21.
//

import SwiftUI
import XMLTree

struct Restriction {
  var importAction: String?
  var dayOfWeek: String
  var startTime: String?
  var endTime: String?
}

extension Restriction: Decodable {
  enum CodingKeys: String, CodingKey {
    case importAction = "ImportAction"
    case dayOfWeek = "DayOfWeek"
    case startTime = "StartTime"
    case endTime = "EndTime"
  }
}

extension Restriction: Hashable {
  
}

extension Restriction: XMLTreeDecodable {
  
  init(from xml: XMLTree) throws {
    try self.init(
      importAction: xml.attrIfPresent("ImportAction"),
      dayOfWeek: xml.attr("DayOfWeek"),
      startTime: xml.attrIfPresent("StartTime"),
      endTime: xml.attrIfPresent("EndTime")
    )
  }
}
