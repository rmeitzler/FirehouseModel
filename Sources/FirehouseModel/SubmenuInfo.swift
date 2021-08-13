//
//  SubmenuInfo.swift
//  SubmenuInfo
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct SubmenuInfo {
  public var id: String
  public var levelNumber: String
}

extension SubmenuInfo: Decodable {
  enum CodingKeys: String, CodingKey {
    case id = "Id"
    case levelNumber = "LevelNumber"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
      id = try values.decode(String.self, forKey: .id)
      levelNumber = try values.decode(String.self, forKey: .levelNumber)
  }
}

extension SubmenuInfo: Hashable {
  
}

extension SubmenuInfo: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    try self.init(id: xml.attr("Id"), levelNumber: xml.attr("LevelNumber"))
  }
}
