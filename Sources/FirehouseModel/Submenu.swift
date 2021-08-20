//
//  Submenu.swift
//  Submenu
//
//  Created by Richard Meitzler on 8/4/21.
//

import SwiftUI
import XMLTree

public struct Submenu {
  public var id: String
  public var name: String
  public var description: String
  public var isVisible: String
  public var isSelectable: String
  public var sourceSubMenuId: String
  public var isShowHeader: String
  public var supportedOrderModes: String
  
  public var menuItemIds: [String]?
  
  public var restrictions: [Restriction]?
  public var customFields: String?
  
  public var menuItems: [MenuItem]
}

extension Submenu: Decodable {
  enum CodingKeys: String, CodingKey {
    case id = "Id"
    case name = "Name"
    case description = "Description"
    case isVisible = "IsVisible"
    case isSelectable = "IsSelectable"
    case sourceSubMenuId = "SourceSubMenuId"
    case isShowHeader = "IsShowHeader"
    case supportedOrderModes = "SupportedOrderModes"
    case menuItemIds = "MenuItems"
    case restrictions = "Restrictions"
    case customFields = "CustomFields"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
    id = try values.decode(String.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    description = try values.decode(String.self, forKey: .description)
    isVisible = try values.decode(String.self, forKey: .isVisible)
    isSelectable = try values.decode(String.self, forKey: .isSelectable)
    sourceSubMenuId = try values.decode(String.self, forKey: .sourceSubMenuId)
    isShowHeader = try values.decode(String.self, forKey: .isShowHeader)
    supportedOrderModes = try values.decode(String.self, forKey: .supportedOrderModes)
    menuItemIds = try values.decodeIfPresent([String].self, forKey: .menuItemIds)
    restrictions = try values.decodeIfPresent([Restriction].self, forKey: .restrictions)
    customFields = try values.decodeIfPresent(String.self, forKey: .customFields)
    menuItems = []
  }
}

extension Submenu: Hashable {
  
}

extension Submenu: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    
    let itemIds: [String]? = xml.child(named: "MenuItems")?.valuesOfChildren()
    let restrictions: [Restriction]? = try? xml.child(named: "Restrictions")?.children.decodeAll()
    
    try self.init(id: xml.attr("Id"),
                  name: xml.attr("Name"),
                  description: xml.attr("Description"),
                  isVisible: xml.attr("IsVisible"),
                  isSelectable: xml.attr("IsSelectable"),
                  sourceSubMenuId: xml.attr("SourceSubMenuId"),
                  isShowHeader: xml.attr("IsShowHeader"),
                  supportedOrderModes: xml.attr("SupportedOrderModes"),
                  menuItemIds: itemIds,
                  restrictions: restrictions,
                  customFields: xml.attrIfPresent("CustomFields"),
                  menuItems: [])
  }
}
