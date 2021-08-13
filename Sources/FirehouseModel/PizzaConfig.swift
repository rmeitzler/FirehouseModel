//
//  PizzaConfig.swift
//  PizzaConfig
//
//  Created by Richard Meitzler on 7/29/21.
//

import SwiftUI
import XMLTree

struct PizzaConfig {
  var pizzaCategory: String
  var portionPricingMethod: String
  var portionPricingPercent: String
  var section1Id: String
  var section1Type: String
  var section2Id: String
  var section2Type: String
  var section3Id: String
  var section3Type: String
  var section4Id: String
  var section4Type: String
  
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
}

extension PizzaConfig: Hashable {
  
}

extension PizzaConfig: XMLTreeDecodable {
  init(from xml: XMLTree) throws {
    
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
