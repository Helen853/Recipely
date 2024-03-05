// TermsPolicyPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентера экрана условий политики
protocol TermsPolicyPresenterProtocol {
    /// Закрытие экрана условий политики
    func closeTermsPolicy()
}

/// Презентер экрана условий политики
final class TermsPolicyPresenter {
    private weak var view: TermsPolicyViewControllerProtocol?
    weak var profileCoordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(view: TermsPolicyViewControllerProtocol) {
        self.view = view
    }
}

// MARK: - TermsPolicyPresenter + TermsPolicyPresenterProtocol

extension TermsPolicyPresenter: TermsPolicyPresenterProtocol {
    func closeTermsPolicy() {
        profileCoordinator?.closeViewController()
    }
}
