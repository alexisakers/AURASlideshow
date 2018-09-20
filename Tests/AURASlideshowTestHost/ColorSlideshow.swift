//
//  ColorSlideshow
//
//  This file is part of the AURASlideshow project.
//  Copyright (c) 2018 - present Alexis Aubry authors.
//
//  Licensed under the terms of the MIT License.
//

import UIKit
import AURASlideshow

enum ColorSlideshow: SlideshowItem {

    case red, orange, yellow, green, blue, purple

    static var allCases: [ColorSlideshow] {
        return [.red, .orange, .yellow, .green, .blue, .purple]
    }

    var image: UIImage {
        switch self {
        case .red: return UIImage(named: "SlideshowRed")!
        case .orange: return UIImage(named: "SlideshowOrange")!
        case .yellow: return UIImage(named: "SlideshowYellow")!
        case .green: return UIImage(named: "SlideshowGreen")!
        case .blue: return UIImage(named: "SlideshowBlue")!
        case .purple: return UIImage(named: "SlideshowPurple")!
        }
    }

    var localizedValue: String {
        switch self {
        case .red: return "Red"
        case .orange: return "Orange"
        case .yellow: return "Yellow"
        case .green: return "Green"
        case .blue: return "Blue"
        case .purple: return "Purple"
        }
    }

}
