//
//  SubmenuInclusion.swift
//  SubmenuInclusion
//
//  Created by Richard Meitzler on 8/3/21.
//

import SwiftUI
import XMLTree

public struct SubmenuInclusion: Decodable, Hashable, XMLTreeDecodable {
  
  public init(from decoder: Decoder) throws {
    
  }
  
  public init(from xml: XMLTree) throws {
    self.init()
  }
  
  public init(){
    
  }
    
}
