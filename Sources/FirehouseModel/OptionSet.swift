//
//  OptionSet.swift
//  OptionSet
//
//  Created by Richard Meitzler on 8/2/21.
//

import SwiftUI
import XMLTree

struct OptionSet {
  var id: String
  var name: String
  var isVisible: String
  var groups: [Group]?
}

extension OptionSet: Decodable {
  enum CodingKeys: String, CodingKey {
     case id = "Id"
     case name = "Name"
     case isVisible = "IsVisible"
     case groups = "Groups"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id = try values.decode(String.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    isVisible = try values.decode(String.self, forKey: .isVisible)
    groups = try values.decode([Group].self, forKey: .isVisible)
  }
}

extension OptionSet: Hashable {
  
}

extension OptionSet: XMLTreeDecodable {
  init(from xml: XMLTree) throws {
    //print("groups:\(xml.child(named: "Groups"))")
    let grps: [Group]? = try xml.child(named: "Groups")?.children.decodeAll()
    
    try self.init(id: xml.attr("Id"), name: xml.attr("Name"), isVisible: xml.attr("IsVisible"), groups: grps)
  }
}
