//  Created by dasdom on 08.10.23.
//

import Foundation

enum KeyboardLayout {
  case us
  case de

  var buttonTitle: String {
    switch self {
      case .us:
        return "US"
      case .de:
        return "DE"
    }
  }
}
