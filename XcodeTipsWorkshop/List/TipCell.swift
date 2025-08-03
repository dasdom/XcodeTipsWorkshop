//  Created by Dominik Hauser on 01.09.23.
//  
//


import UIKit

class TipCell: UITableViewCell {
  static var identifier: String {
    return NSStringFromClass(Self.self)
  }
  let titleLabel: UILabel
  let shortcutLabel: UILabel
  let authorNotesLabel: UILabel
  let shortcutHostView: UIView
  let coloredView: UIView

  func update(with tip: Tip, keyboardLayout: KeyboardLayout) {
    titleLabel.text = tip.title
    if let shortcuts = tip.shortcuts(keyboardLayout: keyboardLayout) {
      shortcutHostView.isHidden = false
      shortcutLabel.text = shortcuts.joined(separator: "\n")
    } else {
      shortcutHostView.isHidden = true
    }

    coloredView.layer.borderColor = UIColor.white.cgColor
    coloredView.layer.borderWidth = 2

    authorNotesLabel.text = tip.authorNotes?.joined(separator: "\n")

    #if AUTHOR
    if UserDefaults.standard.acknowledgedTipIds.contains(tip.id) {
      accessoryType = .checkmark
    } else {
      accessoryType = .none
    }
    #endif
  }
}
