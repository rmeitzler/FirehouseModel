//
//  Layout.swift
//  Layout
//
//  Created by Richard Meitzler on 7/29/21.
//

import SwiftUI
import XMLTree

public struct Layout {
  public var menuItems: [MenuItem]
  public var menuItemInclusion: MenuItemInclusion?
  public var salesItems: [SalesItem]
  public var salesGroups: SalesGroups?
  public var salesItemOptions: [SalesItemOption]
  public var submenus: [Submenu]
  public var submenuInclusion: SubmenuInclusion?
  public var menus: [Menu]
  public var menuInclusion: MenuInclusion
  public var defaultOptions: [DefaultOption]
  public var optionGroups: [OptionGroup]
  public var optionSets: [OptionSet]
  public var modifierActionMaps: [ModifierAction]
  public var quickCombos: QuickCombos?
  public var pizzaConfig: PizzaConfig
  
  enum CodingKeys: String, CodingKey {
    case menuItems = "MenuItems"
    case menuItemInclusion = "MenuItemInclusion"
    case salesItems = "SalesItems"
    case salesGroups = "SalesGroups"
    case salesItemOptions = "SalesItemOptions"
    case submenus = "SubMenus"
    case submenuInclusion = "SubMenuInclusion"
    case menus = "Menus"
    case menuInclusion = "MenuInclusion"
    case defaultOptions = "DefaultOptions"
    case optionGroups = "OptionGroups"
    case optionSets = "OptionSets"
    case modifierActionMaps = "ModifierActionMaps"
    case quickCombos = "QuickCombos"
    case pizzaConfig = "PizzaConfig"
  }
}

extension Layout: Hashable {
  
}

extension Layout: Decodable {
  public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
    
      menuItems = try values.decode([MenuItem].self, forKey: .menuItems)
      menuItemInclusion = try values.decode(MenuItemInclusion.self, forKey: .menuItemInclusion)
      salesItems = try values.decode([SalesItem].self, forKey: .salesItems)
      salesGroups = try values.decodeIfPresent(SalesGroups.self, forKey: .salesGroups)
      salesItemOptions = try values.decode([SalesItemOption].self, forKey: .salesItemOptions)
      submenus = try values.decode([Submenu].self, forKey: .submenus)
      submenuInclusion = try values.decodeIfPresent(SubmenuInclusion.self, forKey: .submenuInclusion)
      menus = try values.decode([Menu].self, forKey: .menus)
      menuInclusion = try values.decode(MenuInclusion.self, forKey: .menuInclusion)
      defaultOptions = try values.decode([DefaultOption].self, forKey: .defaultOptions)
      optionGroups = try values.decode([OptionGroup].self, forKey: .optionGroups)
      optionSets = try values.decode([OptionSet].self, forKey: .optionSets)
      modifierActionMaps = try values.decode([ModifierAction].self, forKey: .modifierActionMaps)
      quickCombos = try values.decodeIfPresent(QuickCombos.self, forKey: .quickCombos)
      pizzaConfig = try values.decode(PizzaConfig.self, forKey: .pizzaConfig)
  }
}

extension Layout: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    
    guard let menuItems: [MenuItem] = try xml.child(named: "MenuItems")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [MenuItem].self))
    }
    
    guard let salesItems: [SalesItem] = try xml.child(named: "SalesItems")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [SalesItem].self))
    }
    
    guard let salesItemOptions: [SalesItemOption] = try xml.child(named: "SalesItemOptions")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [SalesItemOption].self))
    }
    
    guard let submenus: [Submenu] = try xml.child(named: "SubMenus")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [Submenu].self))
    }
    
    guard let menus: [Menu] = try xml.child(named: "Menus")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [Menu].self))
    }
    
    guard let menuInclusion: MenuInclusion = try xml.child(named: "MenuInclusion")?.decode() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: MenuInclusion.self))
    }
    
    guard let defaultOptions: [DefaultOption] = try xml.child(named: "DefaultOptions")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [DefaultOption].self))
    }
    
    guard let optionGroups: [OptionGroup] = try xml.child(named: "OptionGroups")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: [OptionGroup].self))
    }
    
    guard let optionSets: [OptionSet] = try xml.child(named: "OptionSets")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: OptionSet.self))
    }
    
    guard let modifierActionMaps: [ModifierAction] = try xml.child(named: "ModifierActionMaps")?.children.decodeAll() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: ModifierAction.self))
    }
    
    guard let pizzaConfig: PizzaConfig = try xml.child(named: "PizzaConfig")?.decode() else {
      throw XMLTreeError.couldNotDecodeClass(String(describing: PizzaConfig.self))
    }
    
    
//    guard let quickCombos: QuickCombos = try xml.child(named: "QuickCombos")?.decode() else {
//      throw XMLTreeError.couldNotDecodeClass(String(describing: QuickCombos.self))
//    }

    self.init(
    menuItems: menuItems,
    menuItemInclusion: try xml.child(named: "MenuItemInclusion")?.decodeIfPresent(),
    salesItems: salesItems,
    salesGroups: try xml.child(named: "SalesGroups")?.decodeIfPresent(),
    salesItemOptions: salesItemOptions,
    submenus: submenus,
    submenuInclusion: try xml.child(named: "SubMenuInclusion")?.decodeIfPresent(),
    menus: menus,
    menuInclusion: menuInclusion,
    defaultOptions: defaultOptions,
    optionGroups: optionGroups,
    optionSets: optionSets,
    modifierActionMaps: modifierActionMaps,
    quickCombos: try xml.child(named: "QuickCombos")?.decodeIfPresent(),
    pizzaConfig: pizzaConfig)
  }
}

extension Layout {
  
  public func menuItem(by id: String) -> MenuItem? {
    return menuItems.filter({$0.id == id}).first
  }
  
  public func salesItemOption(by id: String) -> SalesItemOption? {
    return salesItemOptions.filter({$0.id == id}).first
  }
  
  public func optionSet(by id: String) -> OptionSet? {
    return optionSets.filter({$0.id == id}).first
  }
  
  public func salesItemOption(by id: String) -> SalesItemOption? {
    return salesItemOptions.filter({$0.id == id}).first
  }
  
}
