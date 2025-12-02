//
//  OnboardingPageService.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 27.11.2025.
//

import Foundation

protocol PageIndexServiceProtocol: AnyObject {
    var currentIndex: Int { get }
    var numberOfPages: Int { get }
    var isLastPage: Bool { get }
    
    func getPageAtIndex(_ index: Int) -> OnboardingPage?
    func moveToNextPage()
    func moveToPreviousPage()
    func setCurrentIndex(_ index: Int)
    func resetToFirstPage()
}

final class PageIndexService: PageIndexServiceProtocol {
    var numberOfPages: Int {
        pages.count
    }
    
    var isLastPage: Bool {
        return currentIndex == numberOfPages - 1
    }
    
    private(set) var currentIndex: Int = 0
    private let pages: [OnboardingPage]
    private let totalPages: Int

    private var canMoveNext: Bool {
        currentIndex < totalPages - 1
    }
    
    private var canMovePrevious: Bool {
        currentIndex > 0
    }

    init(pages: [OnboardingPage]) {
        self.pages = pages
        self.totalPages = pages.count
    }

    func getPageAtIndex(_ index: Int) -> OnboardingPage? {
        guard index >= 0 && index < totalPages else { return nil }
        return pages[index]
    }

    func moveToNextPage() {
        guard canMoveNext else { return }
        currentIndex += 1
    }

    func moveToPreviousPage() {
        guard canMovePrevious else { return }
        currentIndex -= 1
    }

    func setCurrentIndex(_ index: Int) {
        guard index >= 0 && index < totalPages else { return }
        currentIndex = index
    }

    func resetToFirstPage() {
        currentIndex = 0
    }
}
