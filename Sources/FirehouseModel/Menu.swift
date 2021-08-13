//
//  Menu.swift
//  Menu
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct Menu {
  public var id: String
  public var name: String
  public var isVisible: String
  public var sourceMenuId: String
  public var menuType: String
  public var externalId: String
  public var supportedOrderModes: String
  public var menuAttributes: String
  
  public var submenus: [SubmenuInfo]
}

extension Menu: Decodable {
  enum CodingKeys: String, CodingKey {
    case id = "Id"
    case name = "Name"
    case isVisible = "IsVisible"
    case sourceMenuId = "SourceMenuId"
    case menuType = "MenuType"
    case externalId = "ExternalId"
    case supportedOrderModes = "SupportedOrderModes"
    case menuAttributes = "MenuAttributes"
    case submenus = "SubMenus"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
    id = try values.decode(String.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    isVisible = try values.decode(String.self, forKey: .isVisible)
    sourceMenuId = try values.decode(String.self, forKey: .sourceMenuId)
    menuType = try values.decode(String.self, forKey: .menuType)
    externalId = try values.decode(String.self, forKey: .externalId)
    supportedOrderModes = try values.decode(String.self, forKey: .supportedOrderModes)
    menuAttributes = try values.decode(String.self, forKey: .menuAttributes)
    submenus = try values.decode([SubmenuInfo].self, forKey: .id)
  }
}

extension Menu: Hashable {
  
}

extension Menu: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    guard let submenus: [SubmenuInfo] = try xml.child(named: "SubMenus")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [SubmenuInfo].self))
    }
    
    try self.init(id: xml.attr("Id"),
                  name: xml.attr("Name"),
                  isVisible: xml.attr("IsVisible"),
                  sourceMenuId: xml.attr("SourceMenuId"),
                  menuType: xml.attr("MenuType"),
                  externalId: xml.attr("ExternalId"),
                  supportedOrderModes: xml.attr("SupportedOrderModes"),
                  menuAttributes: xml.attr("MenuAttributes"),
                  submenus: submenus
    )
  }
}
