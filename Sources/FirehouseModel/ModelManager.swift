//
//  File.swift
//  File
//
//  Created by Richard Meitzler on 8/24/21.
//

import SwiftUI
import XMLTree
import Combine

public class ModelManager: ObservableObject {
  @Published private var xmlManager: XMLManager = XMLManager()
  private var subscriber: AnyCancellable?
  @Published public private(set) var model: Layout?
  @Published public private(set) var xmlModel: [XMLTree]?
  
  public init() {
    xmlManager.loadXml(filename: "WebLayout")

    subscriber = xmlManager.$treeData.sink { completion in
      switch completion {
          case .finished:
              print("finished")
          case .failure(let never):
              print(never)
      }
    } receiveValue: { value in
      if let val = value {
          do {
            self.xmlModel = [val]
              let decoded: Layout = try val.decode()
              print("decoded:\(decoded.menus.count) menus")
            self.model = decoded
            
            self.subscriber = nil
          } catch {
              print("layout failed")
          }
      }
    }
  }
  
}


extension ModelManager {
  
  public func submenus(for menuId: String) -> [Submenu]? {
    let submenuIds: [String]? = model?.menus.filter({$0.id == menuId}).first?.submenuIds.map({$0.id})
    return model?.submenus.filter({ submenuIds?.contains($0.id) ?? false })
  }
  
  public func menuItems(for submenuId: String) -> [MenuItem]? {
    let menuitemIds: [String]? = model?.submenus.filter({$0.id == submenuId}).first?.menuItemIds.map({$0})
    return model?.menuItems.filter({ menuitemIds?.contains($0.id) ?? false })
  }
  
  public func salesItems(for menuItemId: String) -> [SalesItem]? {
    let salesItemIds = model?.menuItems.filter({$0.id == menuItemId}).first?.salesItemIds.map({$0})
    return model?.salesItems.filter({ salesItemIds?.contains($0.id) ?? false })
  }
  
  public func optionSet(for salesItemId: String) -> OptionSet? {
    let optionSetId: String? = model?.salesItems.filter({$0.id == salesItemId}).first?.itemOptionSetId
    return model?.optionSets.filter({$0.id == optionSetId ?? ""}).first
  }
  
  public func optionGroups(for optionSetId: String) -> [OptionGroup]? {
    let groupIds: [String]? = model?.optionSets.filter({$0.id == optionSetId}).first?.groups?.map({$0.id})
    return groupIds?.compactMap({ optionGroup(for: $0) })
  }
  
  public func optionGroup(for groupId: String) -> OptionGroup? {
    return model?.optionGroups.filter({$0.id == groupId}).first
  }
  
  public func salesItemOptions(for optionGroupId: String) -> [SalesItemOption]? {
    let optionGroup: OptionGroup? = model?.optionGroups.filter({$0.id == optionGroupId}).first
    let optionIds: [String]? = optionGroup?.options.map({$0.id})
    return optionIds?.compactMap({ salesItemOption(for: $0) })
  }
  
  public func salesItemOption(for optionId: String) -> SalesItemOption? {
    return model?.salesItemOptions.filter({$0.id == optionId}).first
  }
  
//  public func visible(_ submenus: [Submenu]?) -> [Submenu]? {
//    return submenus?.filter({$0.isVisible.lowercased() == "true"})
//  }
  
  public func visible<T: Hideable>(_ submenus: [T]?) -> [T]? {
    return submenus?.filter({$0.isVisible.lowercased() == "true"})
  }
  
  public func defaultSalesItem(for menuItemId: String) -> SalesItem? {
    var matches: [SalesItem] = []
    guard let menuItm = model?.menuItem(by: menuItemId) else {
      return nil
    }
    guard let availableSalesItems = visible(salesItems(for: menuItemId)) else {
      return nil
    }
    
      for itm in availableSalesItems {
        if menuItm.isSandwich() {
          if itm.name.lowercased().contains(menuItm.breadType.rawValue) && itm.name.lowercased().contains(menuItm.size.rawValue) {
            matches.append(itm)
          }
        } else if itm.id == menuItm.defaultItemId {
          matches.append(itm)
        }
      }
    
      if availableSalesItems.count > 0 && matches.count == 0 {
        matches.append(availableSalesItems[0])
      }
  
      if let match = matches.first {
        print("default_match:\(match.name)")
        return match
      }
      return nil
    }
  
}

public protocol Hideable {
  var isVisible: String { get }
}
