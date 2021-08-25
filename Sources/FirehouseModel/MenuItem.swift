//
//  MenuItem.swift
//  MenuItem
//
//  Created by Richard Meitzler on 7/29/21.
//

import SwiftUI
import XMLTree

public struct MenuItem {
  public enum BreadType: String {
    case white
    case wheat
    case none
  }
  
  public enum MenuItemSize: String {
    case small
    case medium
    case large
    case kids
    case cup
    case bowl
    case none
  }
  
  public static var sandwichIds = ["30000","30004","30008","30012","30016","30020","30024","30032","30040","30045","30047","30048","30052","30054","30062","30070","30076","30080","30081","30082","30083","30088","30129","30133","30157","30202","30207","30208","30210","30211","30262","30263","30264","30265","30266","30267","30268","30269","30283","30327","30328","30329","30332","30341","30342","30343","30344","30346","30347","30352","30353","30354","30355","30357"]
  
  public static var kidsIds = ["30207","30208","30210","30211","30352","30353","30354","30355"]
  
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
  
  //public var saleItems: [SalesItem]
  public var breadType: BreadType
  public var size: MenuItemSize
  
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
      //saleItems = []
    
      let isSandwich = MenuItem.isSandwich(id)
      let isKids = MenuItem.isKids(id)
      breadType = isSandwich ? .white : .none
      size = isSandwich ? .medium : .none
      size = isKids ? .kids : size
    }
}

extension MenuItem: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {

    guard let salesItemIds: [String] = xml.child(named: "SalesItems")?.valuesOfChildren() else {
      throw XMLTreeError.problemDecodingNode("MenuItem > SalesItems")
    }
    
    let restrictions: [Restriction]? = try? xml.child(named: "Restrictions")?.children.decodeAll()
    
    let isSandwich = MenuItem.isSandwich(try xml.attr("Id"))
    let isKids = MenuItem.isKids(try xml.attr("Id"))
    
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
                  //saleItems: [],
                  breadType: isSandwich ? .white : .none,
                  size: isKids ? .kids : (isSandwich ? .medium : .none)
                  
    )
  }
}


extension MenuItem {
//  public func availableSalesItems() -> [SalesItem] {
//    return saleItems.filter({$0.isVisible.lowercased() == "true"})
//  }
  
  public static func isKids(_ itemId: String) -> Bool {
    return MenuItem.kidsIds.contains(itemId)
  }
  
  public func isKids() -> Bool {
    return MenuItem.kidsIds.contains(id)
  }
  
  public static func isSandwich(_ itemId: String) -> Bool {
    return MenuItem.sandwichIds.contains(itemId)
  }
  
  public func isSandwich() -> Bool {
    return MenuItem.sandwichIds.contains(id)
  }
  
//  public func defaultSalesItem() -> SalesItem? {
//    var matches: [SalesItem] = []
//    for itm in availableSalesItems() {
//      if isSandwich() {
//        if itm.name.lowercased().contains(breadType.rawValue) && itm.name.lowercased().contains(size.rawValue) {
//          matches.append(itm)
//        }
//      } else if itm.id == defaultItemId {
//        matches.append(itm)
//      }
//    }
//
//    if let match = matches.first {
//      print("default_match:\(match.name)")
//      return match
//    }
//    return nil
//  }
  
}

extension MenuItem: Hideable {}
