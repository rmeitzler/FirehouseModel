//
//  SalesItem.swift
//  SalesItem
//
//  Created by Richard Meitzler on 7/29/21.
//

import SwiftUI
import XMLTree

public struct SalesItem {
  public var id: String
  public var itemId: String
  public var name: String
  public var displayName: String
  public var description: String
  public var receiptDescription: String
  public var price: String
  public var itemOptionSetId: String
  public var isVisible: String
  public var canBeOrderedAsIs: String
  public var itemOrderingMode: String
  public var sourceItemId: String
  public var taxGroupId: String
  public var portionCount: String
  public var quantityMultiplier: String
  public var includedModifierCount: String
  public var discountPrice: String
  public var freeModifierCount: String
  public var caloricValue: String?
  public var customFields: String?
  
  //public var itemOptionSet: OptionSet?
}

extension SalesItem: Decodable {
  enum CodingKeys: String, CodingKey {
     case id = "Id"
     case itemId = "ItemId"
     case name = "Name"
     case displayName = "DisplayName"
     case description = "Description"
     case receiptDescription = "ReceiptDescription"
     case price = "Price"
     case itemOptionSetId = "ItemOptionSetId"
     case isVisible = "IsVisible"
     case canBeOrderedAsIs = "CanBeOrderedAsIs"
     case itemOrderingMode = "ItemOrderingMode"
     case sourceItemId = "SourceItemId"
     case taxGroupId = "TaxGroupId"
     case portionCount = "PortionCount"
     case quantityMultiplier = "QuantityMultiplier"
     case includedModifierCount = "IncludedModifierCount"
     case discountPrice = "DiscountPrice"
     case freeModifierCount = "FreeModifierCount"
     case caloricValue = "CaloricValue"
     case customFields = "CustomFields"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
  
    id = try values.decode(String.self, forKey: .id)
    itemId = try values.decode(String.self, forKey: .itemId)
    name = try values.decode(String.self, forKey: .name)
    displayName = try values.decode(String.self, forKey: .displayName)
    description = try values.decode(String.self, forKey: .description)
    receiptDescription = try values.decode(String.self, forKey: .receiptDescription)
    price = try values.decode(String.self, forKey: .price)
    itemOptionSetId = try values.decode(String.self, forKey: .itemOptionSetId)
    isVisible = try values.decode(String.self, forKey: .isVisible)
    canBeOrderedAsIs = try values.decode(String.self, forKey: .canBeOrderedAsIs)
    itemOrderingMode = try values.decode(String.self, forKey: .itemOrderingMode)
    sourceItemId = try values.decode(String.self, forKey: .sourceItemId)
    taxGroupId = try values.decode(String.self, forKey: .taxGroupId)
    portionCount = try values.decode(String.self, forKey: .portionCount)
    quantityMultiplier = try values.decode(String.self, forKey: .quantityMultiplier)
    includedModifierCount = try values.decode(String.self, forKey: .includedModifierCount)
    discountPrice = try values.decode(String.self, forKey: .discountPrice)
    freeModifierCount = try values.decode(String.self, forKey: .freeModifierCount)
    caloricValue = try values.decodeIfPresent(String.self, forKey: .caloricValue)
    customFields = try values.decodeIfPresent(String.self, forKey: .customFields)
    //itemOptionSet = nil
  }
}

extension SalesItem: Hashable {
  
}

extension SalesItem: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    try self.init(id: xml.attr("Id"),
                  itemId: xml.attr("ItemId"),
                  name: xml.attr("Name"),
                  displayName: xml.attr("DisplayName"),
                  description: xml.attr("Description"),
                  receiptDescription: xml.attr("ReceiptDescription"),
                  price: xml.attr("Price"),
                  itemOptionSetId: xml.attr("ItemOptionSetId"),
                  isVisible: xml.attr("IsVisible"),
                  canBeOrderedAsIs: xml.attr("CanBeOrderedAsIs"),
                  itemOrderingMode: xml.attr("ItemOrderingMode"),
                  sourceItemId: xml.attr("SourceItemId"),
                  taxGroupId: xml.attr("TaxGroupId"),
                  portionCount: xml.attr("PortionCount"),
                  quantityMultiplier: xml.attr("QuantityMultiplier"),
                  includedModifierCount: xml.attr("IncludedModifierCount"),
                  discountPrice: xml.attr("DiscountPrice"),
                  freeModifierCount: xml.attr("FreeModifierCount"),
                  caloricValue: xml.attrIfPresent("CaloricValue"),
                  customFields: xml.attrIfPresent("CustomFields")
                  //itemOptionSet: nil
    )
  }
}

//extension SalesItem {
//  public func availableOptionSet() -> OptionSet? {
//    return itemOptionSet?.isVisible.lowercased() == "true" ? itemOptionSet : nil
//  }
//}

extension SalesItem: Hideable {}
