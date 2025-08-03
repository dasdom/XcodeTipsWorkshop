//  Created by Dominik Hauser on 01.09.23.
//  
//


import Foundation

struct Tip: Codable {
  let id: String
  let category: Category
  let title: String
  let shortcuts: [String]?
  let shortcutsDe: [String]?
  let tipDescription: String?
  let webside: String?
  let authorNotes: [String]?

  init(id: String,
       category: Category,
       title: String,
       shortcuts: [String]? = nil,
       shortcutsDe: [String]? = nil,
       tipDescription: String? = nil,
       webside: String? = nil,
       authorNotes: [String]? = nil) {
    self.id = id
    self.category = category
    self.title = title
    self.shortcuts = shortcuts
    self.shortcutsDe = shortcutsDe
    self.tipDescription = tipDescription
    self.webside = webside
    self.authorNotes = authorNotes
  }

  func shortcuts(keyboardLayout: KeyboardLayout) -> [String]? {
    if let shortcutsDe = shortcutsDe,
       keyboardLayout == .de {
      return shortcutsDe
    } else {
      return shortcuts
    }
  }
}
