//
//  MainViewModel.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

protocol MainViewModelProtocol {
    var titleText: String { get }
}

final class MainViewModel: MainViewModelProtocol {
    private let mainModel: MainModel
    
    init(mainModel: MainModel) {
        self.mainModel = mainModel
    }
    
    var titleText: String {
        mainModel.title
    }
}
