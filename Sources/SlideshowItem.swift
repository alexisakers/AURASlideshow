//
//  SlideshowViewController
//
//  This file is part of the AURASlideshow project.
//  Copyright (c) 2018 - present Alexis Aubry authors.
//
//  Licensed under the terms of the MIT License.
//

import UIKit

/**
 * An item that can be displayed inside a slideshow.
 */

public protocol SlideshowItem {
    /// The image to display.
    var image: UIImage { get }

    /// The description text to display to the user.
    var localizedValue: String { get }
}
