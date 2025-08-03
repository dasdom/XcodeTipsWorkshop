//  Created by Dominik Hauser on 06.10.23.
//  
//


import Foundation

enum Category: String, Codable {
  case none
  case general
  case view
  case find
  case navigate
  case editor
  case interfaceBuilder
  case debug
  case integrate
  case simulator
  case author

  var title: String {
    let title: String
    switch self {
      case .none:
        title = ""
      case .general:
        title = "General"
      case .view:
        title = "View"
      case .find:
        title = "Find"
      case .navigate:
        title = "Navigate"
      case .editor:
        title = "Editor"
      case .interfaceBuilder:
        title = "Interface Builder"
      case .debug:
        title = "Debug"
      case .integrate:
        title = "Integrate"
      case .simulator:
        title = "Simulator"
      case .author:
        title = "Author"
    }
    return title
  }

  var sortOrder: Int {
    let sortOrder: Int
    switch self {
      case .none:
        sortOrder = 0
      case .general:
        sortOrder = 100
      case .view:
        sortOrder = 3
      case .find:
        sortOrder = 4
      case .navigate:
        sortOrder = 2
      case .editor:
        sortOrder = 1
      case .interfaceBuilder:
        sortOrder = 7
      case .debug:
        sortOrder = 6
      case .integrate:
        sortOrder = 8
      case .simulator:
        sortOrder = 5
      case .author:
        sortOrder = 1000
    }
    return sortOrder
  }
}
