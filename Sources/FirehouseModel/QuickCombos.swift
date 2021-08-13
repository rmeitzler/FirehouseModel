//
//  QuickCombos.swift
//  QuickCombos
//
//  Created by Richard Meitzler on 8/2/21.
//

import SwiftUI
import XMLTree

public struct QuickCombos: Decodable, Hashable, XMLTreeDecodable {
  public init(from decoder: Decoder) throws {
    
  }
  
  public init(from xml: XMLTree) throws {
    self.init()
  }
  
  public init(){
    
  }
  
}
