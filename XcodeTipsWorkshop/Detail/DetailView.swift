//  Created by Dominik Hauser on 29.07.25.
//  
//


import SwiftUI
import WebKit

struct DetailView: View {
  let tip: Tip

  var body: some View {
    VStack(spacing: 10) {
      Text(tip.title)
        .font(.title)

      if let shortcuts = tip.shortcuts {
        HStack {
          ForEach(shortcuts, id: \.self) { shortcut in
            Text(shortcut)
              .font(.title2)
              .bold()
              .foregroundColor(.white)
              .cornerRadius(10)
              .background(Color(uiColor: .systemTeal))
              .padding(8)
          }
        }
      }

      if let urlString = tip.webside,
         let url = URL(string: urlString) {
        if #available(iOS 26.0, *) {
          WebView(url: url)
        } else {
          EmptyView()
        }
      }
    }
  }
}

#Preview {
  DetailView(tip: Tip(id: "1234", category: .editor, title: "Increase font size", shortcuts: ["⌘ +", "⌘ -"], webside: "https://xcode.tips/assets/18_increase_decrease_font_size.jpg"))
}
