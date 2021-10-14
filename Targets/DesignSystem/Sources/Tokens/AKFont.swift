//
//  AKFont.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 11/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

/// Utilizar AKFont para adiconar fontes customizadas e de acordo com `Dynamic Type`
/// - Parameters:
///   - fontName: Nome da fonte que foi adicionada na plist
///   - bundle: Bundle que está o arquivo padrão `main`
/// - Returns: Chame a função font(forTextStyle:) para receber uma fonte de acordo com o style da UIFontMetrics
struct AKFont {

    enum StyleKey: String, Decodable {
      case title, title2, title3, body
    }

    struct FontDescription: Decodable {
      let fontSize: CGFloat
      let fontName: String
    }

    typealias StyleDictionary = [StyleKey.RawValue: FontDescription]

    var styleDictionary: StyleDictionary?

    init(fontName: String, bundle: Bundle = .main) {
        if let url = bundle.url(forResource: fontName, withExtension: "plist"),
           let data = try? Data(contentsOf: url)
        {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
        }
    }

    func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        guard let styleKey = StyleKey(rawValue: textStyle.rawValue),
              let fontDescription = styleDictionary?[styleKey.rawValue],
              let font = UIFont(name: fontDescription.fontName,
                                size: fontDescription.fontSize)
        else {
            return UIFont.preferredFont(forTextStyle: textStyle)
        }
        
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
    }
}
