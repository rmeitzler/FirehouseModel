//
//  OptionGroup.swift
//  OptionGroup
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct OptionGroup {
  public var id: String
  public var isFolder: String
  public var name: String
  public var displayName: String
  public var description: String
  public var modifierActionGroupId: String
  public var isVisible: String
  public var minimumItems: String
  public var maximumItems: String
  public var perOptionMaximum: String
  public var perOptionMinimum: String
  public var maxDistinctOptions: String
  public var sourceModifierGroupId: String
  public var itemOrderingMode: String
  public var freeModifiers: String
  public var hideModifier: String
  
  public var options: [Option]
  
  public var customFields: String?
}

extension OptionGroup: Decodable {
  enum CodingKeys: String, CodingKey {
     case id = "Id"
     case isFolder = "IsFolder"
     case name = "Name"
     case displayName = "DisplayName"
     case description = "Description"
     case modifierActionGroupId = "ModifierActionGroupId"
     case isVisible = "IsVisible"
     case minimumItems = "MinimumItems"
     case maximumItems = "MaximumItems"
     case perOptionMaximum = "PerOptionMaximum"
     case perOptionMinimum = "PerOptionMinimum"
     case maxDistinctOptions = "MaxDistinctOptions"
     case sourceModifierGroupId = "SourceModifierGroupId"
     case itemOrderingMode = "ItemOrderingMode"
     case freeModifiers = "FreeModifiers"
     case hideModifier = "HideModifier"
     case options = "Options"
     case customFields = "CustomFields"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
    id = try values.decode(String.self, forKey: .id)
    isFolder = try values.decode(String.self, forKey: .isFolder)
    name = try values.decode(String.self, forKey: .name)
    displayName = try values.decode(String.self, forKey: .displayName)
    description = try values.decode(String.self, forKey: .description)
    modifierActionGroupId = try values.decode(String.self, forKey: .modifierActionGroupId)
    isVisible = try values.decode(String.self, forKey: .isVisible)
    minimumItems = try values.decode(String.self, forKey: .minimumItems)
    maximumItems = try values.decode(String.self, forKey: .maximumItems)
    perOptionMaximum = try values.decode(String.self, forKey: .perOptionMaximum)
    perOptionMinimum = try values.decode(String.self, forKey: .perOptionMinimum)
    maxDistinctOptions = try values.decode(String.self, forKey: .maxDistinctOptions)
    sourceModifierGroupId = try values.decode(String.self, forKey: .sourceModifierGroupId)
    itemOrderingMode = try values.decode(String.self, forKey: .itemOrderingMode)
    freeModifiers = try values.decode(String.self, forKey: .freeModifiers)
    hideModifier = try values.decode(String.self, forKey: .hideModifier)
    options = try values.decode([Option].self, forKey: .options)
    customFields = try values.decodeIfPresent(String.self, forKey: .customFields)
  }
}

extension OptionGroup: Hashable {
  
}

extension OptionGroup: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    
    guard let options: [Option] = try xml.child(named: "Options")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [Option].self))
    }
    
    try self.init(id: xml.attr("Id"),
                  isFolder: xml.attr("IsFolder"),
                  name: xml.attr("Name"),
                  displayName: xml.attr("DisplayName"),
                  description: xml.attr("Description"),
                  modifierActionGroupId: xml.attr("ModifierActionGroupId"),
                  isVisible: xml.attr("IsVisible"),
                  minimumItems: xml.attr("MinimumItems"),
                  maximumItems: xml.attr("MaximumItems"),
                  perOptionMaximum: xml.attr("PerOptionMaximum"),
                  perOptionMinimum: xml.attr("PerOptionMinimum"),
                  maxDistinctOptions: xml.attr("MaxDistinctOptions"),
                  sourceModifierGroupId: xml.attr("SourceModifierGroupId"),
                  itemOrderingMode: xml.attr("ItemOrderingMode"),
                  freeModifiers: xml.attr("FreeModifiers"),
                  hideModifier: xml.attr("HideModifier"),
                  options: options,
                  customFields: xml.attrIfPresent("CustomFields"))
  }
}
