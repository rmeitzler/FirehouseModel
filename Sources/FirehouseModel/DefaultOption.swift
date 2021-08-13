//
//  DefaultOption.swift
//  DefaultOption
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct DefaultOption {
  var id: String
  var entityType: String
  var itemOptionGroupId: String
  var salesItemOptionId: String
  var defaultReason: String
  var defaultQuantity: String
  var modifierAction: String
}

extension DefaultOption: Decodable {
  enum CodingKeys: String, CodingKey {
      case id = "Id"
      case entityType = "EntityType"
      case itemOptionGroupId = "ItemOptionGroupId"
      case salesItemOptionId = "SalesItemOptionId"
      case defaultReason = "DefaultReason"
      case defaultQuantity = "DefaultQuantity"
      case modifierAction = "ModifierAction"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
      id = try values.decode(String.self, forKey: .id)
      entityType = try values.decode(String.self, forKey: .entityType)
      itemOptionGroupId = try values.decode(String.self, forKey: .itemOptionGroupId)
      salesItemOptionId = try values.decode(String.self, forKey: .salesItemOptionId)
      defaultReason = try values.decode(String.self, forKey: .defaultReason)
      defaultQuantity = try values.decode(String.self, forKey: .defaultQuantity)
      modifierAction = try values.decode(String.self, forKey: .modifierAction)
  }
}

extension DefaultOption: Hashable {

}

extension DefaultOption: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    try self.init(id: xml.attr("Id"),
                  entityType: xml.attr("EntityType"),
                  itemOptionGroupId: xml.attr("ItemOptionGroupId"),
                  salesItemOptionId: xml.attr("SalesItemOptionId"),
                  defaultReason: xml.attr("DefaultReason"),
                  defaultQuantity: xml.attr("DefaultQuantity"),
                  modifierAction: xml.attr("ModifierAction"))
  }
}
