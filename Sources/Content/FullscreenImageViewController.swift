//
//  FullscreenImageViewController
//
//  This file is part of the AURASlideshow project.
//  Copyright (c) 2018 - present Alexis Aubry authors.
//
//  Licensed under the terms of the MIT License.
//

import UIKit

/**
 * A view controller that displays a fullscreen image.
 */

class FullscreenImageViewController: UIViewController {

    /// The image displayed by the view controller.
    let image: UIImage

    /// The image view wrapped by the view controller.
    let imageView: UIImageView

    /**
     * Creates the view controller with the image to display.
     * - parameter image: The image to display.
     */

    init(image: UIImage) {
        self.image = image
        self.imageView = UIImageView(image: image)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
    }

    /// Configures the subviews of the controller.
    private func configureSubviews() {
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        view.addSubview(imageView)
        view.backgroundColor = .black
    }

    /// Configures the layout constraints of the subviews.
    private func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

}
