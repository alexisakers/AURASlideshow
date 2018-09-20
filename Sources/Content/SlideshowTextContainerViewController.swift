//
//  SlideshowTextContainerViewController
//
//  This file is part of the AURASlideshow project.
//  Copyright (c) 2018 - present Alexis Aubry authors.
//
//  Licensed under the terms of the MIT License.
//

import UIKit

/**
 * A view controller that displays a label inside a blurred view, in order to display it on top
 * of a slideshow.
 */

class SlideshowTextContainerViewController: UIViewController, UITextViewDelegate {

    /// The label that displays the text.
    let label = UILabel()

    /// The background blur effect view.
    let effectView = UIVisualEffectView()

    // MARK: - Configuration

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
    }

    /// Configures the subviews of the controller.
    private func configureSubviews() {
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = "aura_slideshow.description_text"

        effectView.effect = UIBlurEffect(style: .dark)

        view.addSubview(effectView)
        view.addSubview(label)
    }

    /// Configures the layout constraints of the subviews.
    private func configureConstraints() {
        effectView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        let bottomGuide: NSLayoutYAxisAnchor

        if #available(iOS 11, *) {
            bottomGuide = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            bottomGuide = view.bottomAnchor
        }

        let constraints: [NSLayoutConstraint] = [
            // Effect view
            effectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            effectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            effectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // Label
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: bottomGuide, constant: -16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            // Adaptive height
            effectView.topAnchor.constraint(equalTo: label.topAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Label

    /**
     * Changes the text displayed in the container.
     * - parameter text: The new text.
     */

    func updateText(_ text: String) {
        label.text = text
    }

}
