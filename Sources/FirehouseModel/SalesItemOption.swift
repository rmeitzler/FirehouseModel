//
//  SalesItemOption.swift
//  SalesItemOption
//
//  Created by Richard Meitzler on 8/4/21.
//

import SwiftUI
import XMLTree

struct SalesItemOption {
  var id: String
  var modifierId: String
  var name: String
  var displayName: String
  var description: String
  var receiptDescription: String
  var isVisible: String
  var itemOptionSetId: String
  var sourceModifierId: String
  var taxGroupId: String
  var customFields: String?
}

extension SalesItemOption: Decodable {
  enum CodingKeys: String, CodingKey {
     case id = "Id"
     case modifierId = "ModifierId"
     case name = "Name"
     case displayName = "DisplayName"
     case description = "Description"
     case receiptDescription = "ReceiptDescription"
     case isVisible = "IsVisible"
     case itemOptionSetId = "ItemOptionSetId"
     case sourceModifierId = "SourceModifierId"
     case taxGroupId = "TaxGroupId"
     case customFields = "CustomFields"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
    id = try values.decode(String.self, forKey: .id)
    modifierId = try values.decode(String.self, forKey: .modifierId)
    name = try values.decode(String.self, forKey: .name)
    displayName = try values.decode(String.self, forKey: .displayName)
    description = try values.decode(String.self, forKey: .description)
    receiptDescription = try values.decode(String.self, forKey: .receiptDescription)
    isVisible = try values.decode(String.self, forKey: .isVisible)
    itemOptionSetId = try values.decode(String.self, forKey: .itemOptionSetId)
    sourceModifierId = try values.decode(String.self, forKey: .sourceModifierId)
    taxGroupId = try values.decode(String.self, forKey: .taxGroupId)
    customFields = try values.decodeIfPresent(String.self, forKey: .customFields)
  }
}

extension SalesItemOption: Hashable {
  
}

extension SalesItemOption: XMLTreeDecodable {
  init(from xml: XMLTree) throws {
    try self.init(id: xml.attr("Id"),
                  modifierId: xml.attr("ModifierId"),
                  name: xml.attr("Name"),
                  displayName: xml.attr("DisplayName"),
                  description: xml.attr("Description"),
                  receiptDescription: xml.attr("ReceiptDescription"),
                  isVisible: xml.attr("IsVisible"),
                  itemOptionSetId: xml.attr("ItemOptionSetId"),
                  sourceModifierId: xml.attr("SourceModifierId"),
                  taxGroupId: xml.attr("TaxGroupId"),
                  customFields: xml.attrIfPresent("CustomFields"))
  }
}
