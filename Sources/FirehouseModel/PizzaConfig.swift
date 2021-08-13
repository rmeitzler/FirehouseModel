//
//  PizzaConfig.swift
//  PizzaConfig
//
//  Created by Richard Meitzler on 7/29/21.
//

import SwiftUI
import XMLTree

public struct PizzaConfig {
  public var pizzaCategory: String
  public var portionPricingMethod: String
  public var portionPricingPercent: String
  public var section1Id: String
  public var section1Type: String
  public var section2Id: String
  public var section2Type: String
  public var section3Id: String
  public var section3Type: String
  public var section4Id: String
  public var section4Type: String
  
}

extension PizzaConfig: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case pizzaCategory = "PizzaCategory"
    case portionPricingMethod = "PortionPricingMethod"
    case portionPricingPercent = "PortionPricingPercent"
    case section1Id = "Section1Id"
    case section1Type = "Section1Type"
    case section2Id = "Section2Id"
    case section2Type = "Section2Type"
    case section3Id = "Section3Id"
    case section3Type = "Section3Type"
    case section4Id = "Section4Id"
    case section4Type = "Section4Type"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.init(pizzaCategory: try values.decode(String.self, forKey: .pizzaCategory),
              portionPricingMethod: try values.decode(String.self, forKey: .portionPricingMethod),
              portionPricingPercent: try values.decode(String.self, forKey: .portionPricingPercent),
              section1Id: try values.decode(String.self, forKey: .section1Id),
              section1Type: try values.decode(String.self, forKey: .section1Type),
              section2Id: try values.decode(String.self, forKey: .section2Id),
              section2Type: try values.decode(String.self, forKey: .section2Type),
              section3Id: try values.decode(String.self, forKey: .section3Id),
              section3Type: try values.decode(String.self, forKey: .section3Type),
              section4Id: try values.decode(String.self, forKey: .section4Id),
              section4Type: try values.decode(String.self, forKey: .section4Type))
  }
}

extension PizzaConfig: Hashable {
  
}

extension PizzaConfig: XMLTreeDecodable {
  public init(from xml: XMLTree) throws {
    
    try self.init(pizzaCategory: xml.attr("PizzaCategory"),
                  portionPricingMethod: xml.attr("PortionPricingMethod"),
                  portionPricingPercent: xml.attr("PortionPricingPercent"),
                  section1Id: xml.attr("Section1Id"),
                  section1Type: xml.attr("Section1Type"),
                  section2Id: xml.attr("Section2Id"),
                  section2Type: xml.attr("Section2Type"),
                  section3Id: xml.attr("Section3Id"),
                  section3Type: xml.attr("Section3Type"),
                  section4Id: xml.attr("Section4Id"),
                  section4Type: xml.attr("Section4Type"))
  }
  
}
