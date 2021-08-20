//
//  MenuItem.swift
//  MenuItem
//
//  Created by Richard Meitzler on 7/29/21.
//

import SwiftUI
import XMLTree

public struct MenuItem {
  public var id: String
  public var name: String
  public var displayName: String
  public var description: String
  public var defaultItemId: String
  public var isVisible: String
  public var itemOrderingMode: String
  public var forceInitialQuantitySelection: String
  public var layoutBindingTag: String?
  public var baseImageName: String?
  public var sourceItemId: String
  public var listImageName: String?
  public var promotionType: String
  public var promotionDescription: String?
  public var promotionMenuItemId: String
  public var promoId: String
  public var price: String
  public var caloricServingUnit: String?
  public var supportedOrderModes: String
  public var salesItemIds: [String]
  public var salesGroups: String?
  public var restrictions: [Restriction]?
  public var customFields: String?
  
  public var saleItems: [SalesItem]
  
  enum CodingKeys: String, CodingKey {
    case id = "Id"
    case name = "Name"
    case displayName = "DisplayName"
    case description = "Description"
    case defaultItemId = "DefaultItemId"
    case isVisible = "IsVisible"
    case itemOrderingMode = "ItemOrderingMode"
    case forceInitialQuantitySelection = "ForceInitialQuantitySelection"
    case layoutBindingTag = "LayoutBindingTag"
    case baseImageName = "BaseImageName"
    case sourceItemId = "SourceItemId"
    case listImageName = "ListImageName"
    case promotionType = "ServEnt:PromotionType"
    case promotionDescription = "PromotionDescription"
    case promotionMenuItemId = "PromotionMenuItemId"
    case promoId = "PromoID"
    case price = "Price"
    case caloricServingUnit = "CaloricServingUnit"
    case supportedOrderModes = "SupportedOrderModes"
    case salesItemIds = "SalesItems"
    case salesGroups = "SalesGroups"
    case restrictions = "Restrictions"
    case customFields = "CustomFields"
  }
}

extension MenuItem: Hashable {
  
}

extension MenuItem: Decodable {
  public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
      
      id = try values.decode(String.self, forKey: .id)
      name = try values.decode(String.self, forKey: .name)
      displayName = try values.decode(String.self, forKey: .displayName)
      description = try values.decode(String.self, forKey: .description)
      defaultItemId = try values.decode(String.self, forKey: .defaultItemId)
      isVisible = try values.decode(String.self, forKey: .isVisible)
      itemOrderingMode = try values.decode(String.self, forKey: .itemOrderingMode)
      forceInitialQuantitySelection = try values.decode(String.self, forKey: .forceInitialQuantitySelection)
      layoutBindingTag = try values.decodeIfPresent(String.self, forKey: .layoutBindingTag)
      baseImageName = try values.decodeIfPresent(String.self, forKey: .baseImageName)
      sourceItemId = try values.decode(String.self, forKey: .sourceItemId)
      listImageName = try values.decodeIfPresent(String.self, forKey: .listImageName)
      promotionType = try values.decode(String.self, forKey: .promotionType)
      promotionDescription = try values.decodeIfPresent(String.self, forKey: .promotionDescription)
      promotionMenuItemId = try values.decode(String.self, forKey: .promotionMenuItemId)
      promoId = try values.decode(String.self, forKey: .promoId)
      price = try values.decode(String.self, forKey: .price)
      caloricServingUnit = try values.decodeIfPresent(String.self, forKey: .caloricServingUnit)
      supportedOrderModes = try values.decode(String.self, forKey: .supportedOrderModes)
      salesItemIds = try values.decode([String].self, forKey: .salesItemIds)
      salesGroups = try values.decodeIfPresent(String.self, forKey: .salesGroups)
      restrictions = try values.decodeIfPresent([Restriction].self, forKey: .restrictions)
      customFields = try values.decodeIfPresent(String.self, forKey: .customFields)
      saleItems = []
    }
}

extension MenuItem: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {

    guard let salesItemIds: [String] = xml.child(named: "SalesItems")?.valuesOfChildren() else {
      throw XMLTreeError.problemDecodingNode("MenuItem > SalesItems")
    }
    
    let restrictions: [Restriction]? = try? xml.child(named: "Restrictions")?.children.decodeAll()
    
    //CodingKeys.promoId.stringValue
    try self.init(id: xml.attr("Id"),
                  name: xml.attr("Name"),
                  displayName: xml.attr("DisplayName"),
                  description: xml.attr("Description"),
                  defaultItemId: xml.attr("DefaultItemId"),
                  isVisible: xml.attr("IsVisible"),
                  itemOrderingMode: xml.attr("ItemOrderingMode"),
                  forceInitialQuantitySelection: xml.attr("ForceInitialQuantitySelection"),
                  layoutBindingTag: xml.attrIfPresent("LayoutBindingTag"),
                  baseImageName: xml.attrIfPresent("BaseImageName"),
                  sourceItemId: xml.attr("SourceItemId"),
                  listImageName: xml.attrIfPresent("ListImageName"),
                  promotionType: xml.attr("ServEnt:PromotionType"),
                  promotionDescription: xml.attrIfPresent("PromotionDescription"),
                  promotionMenuItemId: xml.attr("PromotionMenuItemId"),
                  promoId: xml.attr("PromoID"),
                  price: xml.attr("Price"),
                  caloricServingUnit: xml.attrIfPresent("CaloricServingUnit"),
                  supportedOrderModes: xml.attr("SupportedOrderModes"),
                  salesItemIds: salesItemIds,
                  salesGroups: xml.attrIfPresent("SalesGroup"),
                  restrictions: restrictions,
                  customFields: xml.attrIfPresent("CustomFields"),
                  saleItems: [])
  }
}
