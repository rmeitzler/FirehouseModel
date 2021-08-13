//
//  ModifierAction.swift
//  ModifierAction
//
//  Created by Richard Meitzler on 8/2/21.
//

import SwiftUI
import XMLTree

public struct ModifierAction {
  var modifierActionGroupId: String
  var modifierAction: String
  var action: String
  var displayName: String
  var displayShortName: String
  
}


extension ModifierAction: Decodable {
  enum CodingKeys: String, CodingKey {
    case modifierActionGroupId = "ModifierActionGroupId"
    case modifierAction = "ModifierAction"
    case action = "Action"
    case displayName = "DisplayName"
    case displayShortName = "DisplayShortName"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    modifierActionGroupId = try values.decode(String.self, forKey: .modifierActionGroupId)
    modifierAction = try values.decode(String.self, forKey: .modifierAction)
    action = try values.decode(String.self, forKey: .action)
    displayName = try values.decode(String.self, forKey: .displayName)
    displayShortName = try values.decode(String.self, forKey: .displayShortName)
  }
}

extension ModifierAction: Hashable {
  
}

extension ModifierAction: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    try self.init(modifierActionGroupId: xml.attr("ModifierActionGroupId"),
                  modifierAction: xml.attr("ModifierAction"),
                  action: xml.attr("Action"),
                  displayName: xml.attr("DisplayName"),
                  displayShortName: xml.attr("DisplayShortName"))
  }
}
