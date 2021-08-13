//
//  MenuInclusion.swift
//  MenuInclusion
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct MenuInclusion {
  public var entries: [Entry]
}

extension MenuInclusion: Decodable {
  enum CodingKeys: String, CodingKey {
    case entries = "Entry"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
      entries = try values.decode([Entry].self, forKey: .entries)
  }
}

extension MenuInclusion: Hashable {
  
}

extension MenuInclusion: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    
    guard let entries: [Entry] = try xml.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [Entry].self))
    }
    
    self.init(entries: entries)
  }
}
