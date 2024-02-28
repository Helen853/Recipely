// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для экрана профиля
protocol ProfileViewProtocol: AnyObject {
    func configureAlert()
    func changeLabel(updateName: String)
}

/// Экран профиля пользователя
final class ProfileViewController: UIViewController {
    // MARK: - Visual Components

    private let tableView = UITableView()

    // MARK: - Public Properties

    var profilePresenter: ProfilePresenter?
    var onTapHandler: (() -> ())?
    var arrowTapHandler: (() -> ())?

    // MARK: - Private Properties

    // Массив с моделями ячеек
    private var cells: [CellTypeProtocol] = [
        Info(
            imageName: AppConstants.avatarName,
            fullName: AppConstants.fullName
        ),
        Bonuses(
            imageName: AppConstants.bonuses,
            itemTitle: AppConstants.bonuses
        ),
        Terms(
            imageName: AppConstants.imageTerms,
            itemTitle: AppConstants.termsTitle
        ),
        LogOut(
            imageName: AppConstants.imageLogout,
            itemTitle: AppConstants.logOutText
        )
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureTable()
        registerCell()
        onTap()
        arrowButtonTapped()
    }

    // MARK: - Private Methods

    private func onTap() {
        onTapHandler = { [weak self] in
            guard let self = self else { return }
            profilePresenter?.showAlert()
        }
    }

    private func arrowButtonTapped() {
        arrowTapHandler = { [weak self] in
            guard let self = self else { return }
            profilePresenter?.showBonuses()
        }
    }

    private func configureTitle() {
        navigationItem.title = AppConstants.profile
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func registerCell() {
        tableView.register(
            InfoTableViewCell.self,
            forCellReuseIdentifier: AppConstants.infoIdentifier
        )
        tableView.register(
            BonusesTableViewCell.self,
            forCellReuseIdentifier: AppConstants.bonusesIdentifier
        )
        tableView.register(
            TermsTableViewCell.self,
            forCellReuseIdentifier: AppConstants.termsIdentifier
        )
        tableView.register(
            LogOutTableViewCell.self,
            forCellReuseIdentifier: AppConstants.logOutIdentifier
        )
    }
}

// MARK: - Extension ProfileViewController + UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cells[indexPath.row].cellType

        switch cellType {
        case .info:
            guard
                let cell = tableView
                .dequeueReusableCell(withIdentifier: AppConstants.infoIdentifier) as? InfoTableViewCell,
                let model = cells[indexPath.row] as? Info
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model, tapButton: onTapHandler)
            return cell
        case .bonuses:
            guard
                let cell = tableView
                .dequeueReusableCell(withIdentifier: AppConstants.bonusesIdentifier) as? BonusesTableViewCell,
                let model = cells[indexPath.row] as? Bonuses
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model, tapButton: arrowTapHandler)
            return cell
        case .terms:
            guard
                let cell = tableView
                .dequeueReusableCell(withIdentifier: AppConstants.termsIdentifier) as? TermsTableViewCell,
                let model = cells[indexPath.row] as? Terms
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
        case .logOut:
            guard
                let cell = tableView
                .dequeueReusableCell(withIdentifier: AppConstants.logOutIdentifier) as? LogOutTableViewCell,
                let model = cells[indexPath.row] as? LogOut
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
        }
    }
}

// MARK: - Extension ProfileViewController + ProfileViewProtocol

/// Имплементация ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    // настройка алерта
    func configureAlert() {
        let alertController = UIAlertController(
            title: AppConstants.changeAlertTitle,
            message: nil,
            preferredStyle: .alert
        )
        let actionCancel = UIAlertAction(title: AppConstants.cancel, style: .default)
        let actionOk = UIAlertAction(title: AppConstants.ok, style: .cancel) { _ in
            guard let text = alertController.textFields?.first?.text else { return }
            self.actionOkTap(text: text)
        }
        alertController.addTextField { title in
            title.placeholder = AppConstants.placeholderText
        }
        alertController.addAction(actionCancel)
        alertController.addAction(actionOk)
        present(alertController, animated: true)
    }

    /// Уведомляем презентер о нажатии на "ок" в алерте
    /// - Parametr: текст из текстфилда
    func actionOkTap(text: String) {
        profilePresenter?.changeName(text: text)
    }

    /// Изменение текста лейбла с именем
    /// - Parametr: новое имя
    func changeLabel(updateName: String) {
        cells[0] = Info(
            imageName: AppConstants.avatarName,
            fullName: updateName
        )
        tableView.reloadData()
    }
}
