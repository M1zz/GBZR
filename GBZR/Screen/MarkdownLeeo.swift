//
//  Markdown.swift
//  GBZR
//
//  Created by hyunho lee on 7/10/23.
//

import SwiftUI
import Markdown

struct MarkdownLeeo: View {
    
    var fileName: String
    @State private var content = """
      This screen demonstrates how you can integrate a 3rd party library
      to render syntax-highlighted code blocks.

      First, we create a type that conforms to `CodeSyntaxHighlighter`,
      using [John Sundell's Splash](https://github.com/JohnSundell/Splash)
      to highlight code blocks.

      ```swift
      import MarkdownUI
      import Splash
      import SwiftUI

      struct SplashCodeSyntaxHighlighter: CodeSyntaxHighlighter {
        private let syntaxHighlighter: SyntaxHighlighter<TextOutputFormat>

        init(theme: Splash.Theme) {
          self.syntaxHighlighter = SyntaxHighlighter(format: TextOutputFormat(theme: theme))
        }

        func highlightCode(_ content: String, language: String?) -> Text {
          guard language?.lowercased() == "swift" else {
            return Text(content)
          }

          return self.syntaxHighlighter.highlight(content)
        }
      }

      extension CodeSyntaxHighlighter where Self == SplashCodeSyntaxHighlighter {
        static func splash(theme: Splash.Theme) -> Self {
          SplashCodeSyntaxHighlighter(theme: theme)
        }
      }
      ```

      Then we configure the `Markdown` view to use the `SplashCodeSyntaxHighlighter`
      that we just created.

      ```swift
      var body: some View {
        Markdown(self.content)
          .markdownCodeSyntaxHighlighter(.splash(theme: .sunset(withFont: .init(size: 16))))
      }
      ```
      """
    @State private var content2 = ""

    var body: some View {
//        Markdown(content: $content)
//            .markdownStyle(
//                  MarkdownStyle(
//                    padding: 0, paddingTop: 115, paddingBottom: 2, paddingLeft: 50, paddingRight: 50
//                  )
//              )
//            .background(.blue)
        Markdown(content: $content2)
                    .markdownStyle(
                          MarkdownStyle(
                            padding: 0, paddingTop: 115, paddingBottom: 2, paddingLeft: 50, paddingRight: 50
                          )
                      )
                    .background(.blue)
                    .onAppear {
                        do {
                            if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "md") {
                                // Read the file Data
                                let data = try Data(contentsOf: fileURL)

                                // Convert the Data to a String
                                let str = String(data: data, encoding: .utf8)
                                content2 = str ?? "error"
                                // Optional: Print the string
                                print(str ?? "No string found in file")
                            } else {
                                print("File not found")
                            }
                        } catch let error {
                            // Handle errors here
                            print("Error reading file: \(error)")
                        }
                    }
    }

    
}
//
//#Preview {
//    Markdown()
//}


struct MarkdownLeeo_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownLeeo(fileName: "01")
    }
}

