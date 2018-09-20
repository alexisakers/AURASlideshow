//
//  ViewController
//
//  This file is part of the AURASlideshow project.
//  Copyright (c) 2018 - present Alexis Aubry authors.
//
//  Licensed under the terms of the MIT License.
//

import UIKit
import AURASlideshow

class ViewController: UIViewController {

    @IBAction func openSlideshowTapped() {
        let slideshow = SlideshowViewController(title: "Colors", items: ColorSlideshow.allCases)
        let slideshowNavigation = UINavigationController(rootViewController: slideshow)
        present(slideshowNavigation, animated: true, completion: nil)
    }

}

