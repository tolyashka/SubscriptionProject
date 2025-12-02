//
//  ViewController.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 26.11.2025.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingPageViewController: UIPageViewController {
    weak var flowDelegate: OnboardingPageViewControllerDelegate?

    private let viewModel: OnboardingViewModelProtocol
    private var pageViewControllers: [OnboardingViewController] = []

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        setupViews()
        configurePageViewController()
    }

    private func setupPages() {
        pageControl.numberOfPages = viewModel.numberOfPages
        pageControl.currentPage = viewModel.currentPageIndex
        
        pageViewControllers = viewModel.pages.map {
            let pageViewController = OnboardingViewController()
            pageViewController.updateValues(with: $0)
            pageViewController.delegate = self
            return pageViewController
        }
    }

    private func configurePageViewController() {
        view.backgroundColor = .clear
        dataSource = self
        delegate = self

        if let firstViewController = pageViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: false)
        }
    }

    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipButton.heightAnchor.constraint(equalToConstant: 45),
            skipButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    private func setupViews() {
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        configureLayoutConstraints()
    }

    @objc private func skipTapped() {
        flowDelegate?.onboardingDidFinish()
    }
}

extension OnboardingPageViewController: OnboardingViewControllerDelegate {
    func onboardingViewControllerDidTapNext(_ controller: OnboardingViewController) {
        if viewModel.isLastPage {
            flowDelegate?.onboardingDidFinish()
            return
        }

        viewModel.moveToNextPage()

        let nextVC = pageViewControllers[viewModel.currentPageIndex]
        setViewControllers([nextVC], direction: .forward, animated: true)

        pageControl.currentPage = viewModel.currentPageIndex
    }

    func onboardingViewControllerDidRequestSkip(_ controller: OnboardingViewController) {
        flowDelegate?.onboardingDidFinish()
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingViewController,
              let index = pageViewControllers.firstIndex(of: viewController),
              index > 0 else { // !!!!
            return nil
        }
        
        return pageViewControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingViewController,
              let index = pageViewControllers.firstIndex(of: viewController),
              index < pageViewControllers.count - 1  else { // !!!!
            return nil
        }

        return pageViewControllers[index + 1]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {

        guard completed,
              let viewController = (viewControllers?.first) as? OnboardingViewController,
              let index = pageViewControllers.firstIndex(of: viewController) else { return }

        viewModel.setCurrentIndex(index)
        pageControl.currentPage = index
    }
}
