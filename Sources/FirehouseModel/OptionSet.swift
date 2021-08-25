//
//  OptionSet.swift
//  OptionSet
//
//  Created by Richard Meitzler on 8/2/21.
//

import SwiftUI
import XMLTree

public struct OptionSet {
  public var id: String
  public var name: String
  public var isVisible: String
  public var groups: [Group]?
  
  //public var optionGroups: [OptionGroup]?
}

extension OptionSet: Decodable {
  enum CodingKeys: String, CodingKey {
     case id = "Id"
     case name = "Name"
     case isVisible = "IsVisible"
     case groupIds = "Groups"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id = try values.decode(String.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    isVisible = try values.decode(String.self, forKey: .isVisible)
    groups = try values.decode([Group].self, forKey: .groupIds)
    //optionGroups = nil
  }
}

extension OptionSet: Hashable {
  
}

extension OptionSet: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    let grps: [Group]? = try xml.child(named: "Groups")?.children.decodeAll()
    
    try self.init(id: xml.attr("Id"), name: xml.attr("Name"), isVisible: xml.attr("IsVisible"), groups: grps)
  }
}

extension OptionSet {
  public func groupIds() -> [String]? {
    return groups?.map({$0.id})
  }
}

//extension OptionSet {
//  public func availableOptionGroups() -> [OptionGroup]? {
//    return optionGroups?.filter({$0.isVisible.lowercased() == "true"})
//  }
//}

extension OptionSet: Hideable {}
