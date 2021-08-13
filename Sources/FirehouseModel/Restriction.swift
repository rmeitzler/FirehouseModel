//
//  Restriction.swift
//  Restriction
//
//  Created by Richard Meitzler on 7/29/21.
//

import SwiftUI
import XMLTree

public struct Restriction {
  public var importAction: String?
  public var dayOfWeek: String
  public var startTime: String?
  public var endTime: String?
}

extension Restriction: Decodable {
  enum CodingKeys: String, CodingKey {
    case importAction = "ImportAction"
    case dayOfWeek = "DayOfWeek"
    case startTime = "StartTime"
    case endTime = "EndTime"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.init(importAction: try values.decodeIfPresent(String.self, forKey: .importAction),
              dayOfWeek: try values.decode(String.self, forKey: .dayOfWeek),
              startTime: try values.decodeIfPresent(String.self, forKey: .startTime),
              endTime: try values.decodeIfPresent(String.self, forKey: .endTime))
  }
}

extension Restriction: Hashable {
  
}

extension Restriction: XMLTreeDecodable {
  
  public init(from xml: XMLTree) throws {
    try self.init(
      importAction: xml.attrIfPresent("ImportAction"),
      dayOfWeek: xml.attr("DayOfWeek"),
      startTime: xml.attrIfPresent("StartTime"),
      endTime: xml.attrIfPresent("EndTime")
    )
  }
}
