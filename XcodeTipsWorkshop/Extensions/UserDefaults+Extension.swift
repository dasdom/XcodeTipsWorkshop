//  Created by Dominik Hauser on 04.09.23.
//  
//


import Foundation

extension UserDefaults {
  private var acknowledgedTipIdsKey: String { return "acknowledgedTipIdsKey" }

  var acknowledgedTipIds: [String] {
    get {
      return array(forKey: acknowledgedTipIdsKey) as? [String] ?? []
    }
    set {
      setValue(newValue, forKey: acknowledgedTipIdsKey)
    }
  }
}
