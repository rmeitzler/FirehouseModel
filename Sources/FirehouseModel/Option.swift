//
//  Option.swift
//  Option
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct Option {
  public var id: String
  public var isFolder: String
  public var modifierGroupId: String
  public var price: String
  public var modifierAction: String
  public var weight: String
  public var customFields: String?
  
  //public var salesItemOption: SalesItemOption?
}

extension Option: Decodable {
  enum CodingKeys: String, CodingKey {
     case id = "Id"
     case isFolder = "IsFolder"
     case modifierGroupId = "ModifierGroupId"
     case price = "Price"
     case modifierAction = "ModifierAction"
     case weight = "Weight"
     case customFields = "CustomFields"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
    id = try values.decode(String.self, forKey: .id)
    isFolder = try values.decode(String.self, forKey: .isFolder)
    modifierGroupId = try values.decode(String.self, forKey: .modifierGroupId)
    price = try values.decode(String.self, forKey: .price)
    modifierAction = try values.decode(String.self, forKey: .modifierAction)
    weight = try values.decode(String.self, forKey: .weight)
    customFields = try values.decodeIfPresent(String.self, forKey: .customFields)
    //salesItemOption = nil
  }
}

extension Option: Hashable {
  
}

extension Option: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    
    try self.init(id: xml.attr("Id"),
              isFolder: xml.attr("IsFolder"),
              modifierGroupId: xml.attr("ModifierGroupId"),
              price: xml.attr("Price"),
              modifierAction: xml.attr("ModifierAction"),
              weight: xml.attr("Weight"),
              customFields: xml.attrIfPresent("CustomFields")
              //salesItemOption: nil
    )
  }
}
