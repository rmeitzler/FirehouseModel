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
  @Published private(set) var model: Layout?
  @Published private(set) var xmlModel: [XMLTree]?
  
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
