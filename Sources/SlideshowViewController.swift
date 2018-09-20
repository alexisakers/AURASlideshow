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
 * A view controller that displays a slideshow of images.
 *
 * When you create this view controller, you specify the title to display in the navigation bar,
 * and the objects that provide the images to display and localized description to display below
 * the text.
 */

public class SlideshowViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIGestureRecognizerDelegate {

    // MARK: - State

    /// The items displayed inside the slideshow.
    let items: [SlideshowItem]

    /// The list of view controllers to the display.
    var viewControllers: [UIViewController] = []

    /// The map of view controllers to the corresponding item.
    var viewControllersForItem: [UIViewController: SlideshowItem] = [:]

    // MARK: - Interface

    /// The page view controller that contains the pages.
    let pageController: UIPageViewController

    /// The view controller that displays the text.
    let textContainer = SlideshowTextContainerViewController()

    /// The button to show the next item.
    var nextButton: UIBarButtonItem?

    /// The button to show the previous item.
    var previousButton: UIBarButtonItem?

    /// Whether the interface is hidden in response to a user tap.
    var isInterfaceHidden: Bool = false

    // MARK: - Initialization

    /**
     * Creates the slideshow interface for the specified content.
     * - parameter title: The title of the slideshow.
     * - parameter items: The items to display in the slideshow of images.
     */

    public init(title: String, items: [SlideshowItem]) {
        precondition(items.count > 0, "Cannot create an empty slideshow.")
        self.items = items

        let pagingOptions: [UIPageViewController.OptionsKey : Any] = [.interPageSpacing: CGFloat(24)]
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: pagingOptions)

        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Customization

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    public override var prefersStatusBarHidden: Bool {
        return isInterfaceHidden
    }

    // MARK: - Configuration

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        configureSubviews()
        configureConstraints()
        configureGestureRecognizers()
        configureNavigationBar()
    }

    /// Configure the items to display in the slideshow.
    private func configureItems() {
        var viewControllers: [UIViewController] = []
        var viewControllersForItem: [UIViewController: SlideshowItem] = [:]

        for item in items {
            let vc = FullscreenImageViewController(image: item.image)
            viewControllers.append(vc)
            viewControllersForItem[vc] = item
        }

        self.viewControllers = viewControllers
        self.viewControllersForItem = viewControllersForItem

        pageController.setViewControllers([viewControllers.first!], direction: .forward, animated: false)
        displayText(for: items.first!)
    }

    /// Configures the subviews of the controller.
    private func configureSubviews() {
        view.backgroundColor = .black
        view.tintColor = .white

        pageController.dataSource = self
        pageController.delegate = self
        pageController.view.accessibilityIdentifier = "aura_slideshow.page_controller"

        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)

        addChild(textContainer)
        view.addSubview(textContainer.view)
        textContainer.didMove(toParent: self)

        view.accessibilityElements = [pageController.view, textContainer.view]
    }

    /// Configures the navigation bar for this view controller.
    private func configureNavigationBar() {
        if #available(iOS 11, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = .white

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.leftBarButtonItem = doneButton
    }

    /// Configures the gesture recognizers.
    private func configureGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapScreen))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        pageController.view.addGestureRecognizer(tapGesture)
    }

    //// Configures the layout constraints.
    private func configureConstraints() {
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        textContainer.view.translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            // Page container
            pageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // Text container
            textContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Actions

    public override func accessibilityPerformEscape() -> Bool {
        dismiss(animated: true, completion: nil)
        return true
    }

    /// Called when the done button is tapped to dismiss the screen.
    @objc func doneButtonTapped(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    /// Called when the user taps the screen to show or hide the text.
    @objc func userDidTapScreen() {
        self.isInterfaceHidden = !self.isInterfaceHidden

        navigationController?.setNavigationBarHidden(isInterfaceHidden, animated: true)
        setNeedsStatusBarAppearanceUpdate()

        UIView.animate(withDuration: 0.3) {
            self.textContainer.view.alpha = self.isInterfaceHidden ? 0 : 1
        }
    }

    /// Displays the text for the specified item.
    func displayText(for item: SlideshowItem) {
        textContainer.updateText(item.localizedValue)
        textContainer.view.isHidden = false
    }

    // MARK: - Scrolling

    /**
     * Determine the next or previous view controller to display based on the scroll direction.
     * - parameter current: The current view controller.
     * - parameter forwardDirection: Whether the user asked for the next view controller (`true`),
     * or the previous view controller (`false`).
     * - returns: The view controller to display after the user interaction ends.
     */

    func determineViewController(after current: UIViewController, forwardDirection: Bool) -> UIViewController? {
        guard let index = viewControllers.index(of: current) else {
            return nil
        }

        let offset = forwardDirection ? 1 : -1
        let limit = forwardDirection ? viewControllers.endIndex - 1 : viewControllers.startIndex

        guard let nextSequentialIndex = viewControllers.index(index, offsetBy: offset, limitedBy: limit) else {
            return nil
        }

        return viewControllers[nextSequentialIndex]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return determineViewController(after: viewController, forwardDirection: false)
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return determineViewController(after: viewController, forwardDirection: true)
    }

    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {
            return
        }

        guard let viewController = pageViewController.viewControllers?.first, let item = viewControllersForItem[viewController] else {
            return
        }

        displayText(for: item)
    }

    // MARK: - Accessibility

    /// Switch to the appropriate slideshow item when the user performs an accessibility scroll.
    public override func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
        guard let currentViewController = pageController.viewControllers?.first else {
            return false
        }

        // Determine the scroll direction

        let isForwardScroll: Bool

        switch direction {
        case .left:
            isForwardScroll = view.effectiveUserInterfaceLayoutDirection == .leftToRight ? true : false
        case .right:
            isForwardScroll = view.effectiveUserInterfaceLayoutDirection == .leftToRight ? false : true
        case .previous:
            isForwardScroll = false
        case .next:
            isForwardScroll = true
        case .down, .up:
            return false
        }

        // Display the correct UI and announce the change to the accessibility engine

        guard let nextViewController = determineViewController(after: currentViewController, forwardDirection: isForwardScroll) else {
            return false
        }

        guard let item = viewControllersForItem[nextViewController] else {
            return false
        }

        pageController.setViewControllers([nextViewController], direction: isForwardScroll ? .forward : .reverse, animated: true) { completed in
            if completed {
                self.displayText(for: item)
                UIAccessibility.post(notification: UIAccessibility.Notification.pageScrolled,
                                     argument: item.localizedValue)
            }
        }

        return true
    }

    /// Disable tap to hide text when voice over is running.
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !UIAccessibility.isVoiceOverRunning
    }

}
