//
//  SalesGroups.swift
//  SalesGroups
//
//  Created by Richard Meitzler on 8/4/21.
//

import SwiftUI
import XMLTree

public struct SalesGroups: Decodable, Hashable, XMLTreeDecodable {
  
  public init(from decoder: Decoder) throws {
    
  }
  
  public init(from xml: XMLTree) throws {
    self.init()
  }
  
  public init(){
    
  }
    
}
