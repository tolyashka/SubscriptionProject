//
//  OnboardingViewModel.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 26.11.2025.
//

import Foundation

protocol OnboardingViewModelProtocol {
    var isLastPage: Bool { get }
    var pages: [OnboardingPage] { get }
    var currentPageIndex: Int { get }
    var numberOfPages: Int { get }
    
    func moveToNextPage()
    func setCurrentIndex(_ index: Int)
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    let pages: [OnboardingPage]
    private let pageIndexService: PageIndexServiceProtocol

    init(pages: [OnboardingPage], pageIndexService: PageIndexServiceProtocol) {
        self.pages = pages
        self.pageIndexService = pageIndexService
    }

    var isLastPage: Bool {
        pageIndexService.isLastPage
    }
    
    var currentPageIndex: Int {
        pageIndexService.currentIndex
    }

    var numberOfPages: Int {
        pageIndexService.numberOfPages
    }

    func moveToNextPage() {
        pageIndexService.moveToNextPage()
    }
    
    func setCurrentIndex(_ index: Int) {
        pageIndexService.setCurrentIndex(index)
    }
}
