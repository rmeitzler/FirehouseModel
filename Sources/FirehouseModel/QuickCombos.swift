//
//  QuickCombos.swift
//  QuickCombos
//
//  Created by Richard Meitzler on 8/2/21.
//

import SwiftUI
import XMLTree

struct QuickCombos: Decodable, Hashable, XMLTreeDecodable {
  init(from decoder: Decoder) throws {
    
  }
  
  init(from xml: XMLTree) throws {
    self.init()
  }
  
  init(){
    
  }
  
}
