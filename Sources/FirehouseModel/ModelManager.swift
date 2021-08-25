//
//  File.swift
//  File
//
//  Created by Richard Meitzler on 8/24/21.
//

import SwiftUI
import XMLTree
import Combine

class ModelManager: ObservableObject {
  @StateObject var xmlManager: XMLManager
  
  //@Published private(set) var model: Layout
  
  init() {
    let mgr = XMLManager()
    _xmlManager = StateObject(wrappedValue: mgr)
    xmlManager.loadXml(filename: "WebLayout")
    
//    let xmlSubscriber = XMLTreeSubscriber()
//    xmlManager.treeData!.publisher().subscribe(xmlSubscriber)
    
    _ = xmlManager.$treeData.sink { completion in
      switch completion {
              case .finished:
                  print("finished")
              case .failure(let never):
                  print(never)
          }
    } receiveValue: { value in
      print("value::\(String(describing: value))")
    }

    
  }
}


class XMLTreeSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received: \(input)")
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completion event:", completion)
    }
}
