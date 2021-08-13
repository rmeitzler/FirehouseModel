//
//  Entry.swift
//  Entry
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct Entry {
  public var id: String
  public var siteGroupId: String
  public var isIncluded: String
}

extension Entry: Decodable {
  enum CodingKeys: String, CodingKey {
    case id = "Id"
    case siteGroupId = "SiteGroupId"
    case isIncluded = "IsIncluded"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
    id = try values.decode(String.self, forKey: .id)
    siteGroupId = try values.decode(String.self, forKey: .siteGroupId)
    isIncluded = try values.decode(String.self, forKey: .isIncluded)
  }
}

extension Entry: Hashable {
  
}

extension Entry: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    try self.init(id: xml.attr("Id"), siteGroupId: xml.attr("SiteGroupId"), isIncluded: xml.attr("IsIncluded"))
  }
}
