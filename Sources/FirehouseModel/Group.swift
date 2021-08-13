//
//  Group.swift
//  Group
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct Group {
  public var id: String
  public var isHalfSectionAllowed: String
  public var isThirdSectionAllowed: String
  public var isFourthSectionAllowed: String
}

extension Group: Decodable {
  enum CodingKeys: String, CodingKey {
     case id = "Id"
     case isHalfSectionAllowed = "IsHalfSectionAllowed"
     case isThirdSectionAllowed = "IsThirdSectionAllowed"
     case isFourthSectionAllowed = "IsFourthSectionAllowed"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
    id = try values.decode(String.self, forKey: .id)
    isHalfSectionAllowed = try values.decode(String.self, forKey: .isHalfSectionAllowed)
    isThirdSectionAllowed = try values.decode(String.self, forKey: .isThirdSectionAllowed)
    isFourthSectionAllowed = try values.decode(String.self, forKey: .isFourthSectionAllowed)
  }
}

extension Group: Hashable {
  
}

extension Group: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    //print("group:\(xml)")
    try self.init(id: xml.attr("Id"), isHalfSectionAllowed: xml.attr("IsHalfSectionAllowed"), isThirdSectionAllowed: xml.attr("IsThirdSectionAllowed"), isFourthSectionAllowed: xml.attr("IsFourthSectionAllowed"))
  }
}
