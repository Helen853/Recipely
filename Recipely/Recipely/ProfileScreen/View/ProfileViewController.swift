// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля пользователя
class ProfileViewController: UIViewController {
    var profilePresenter: ProfilePresenter?

    private let tableView = UITableView()

    var onTapHandler: (() -> ())?

    // Массив с моделями ячеек
    private let cells: [CellTypeProtocol] = [
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureTable()
        registerCell()
        onTap()
    }

    func onTap() {
        onTapHandler = { [weak self] in
            guard let self = self else { return }
            profilePresenter?.showAlert()
        }
    }

    private func configureTitle() {
        navigationItem.title = AppConstants.profile
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTable() {
        view.addSubview(tableView)
        // tableView.delegate = self
        tableView.dataSource = self
        // tableView.separatorStyle = .none
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

// MARK: - Extension UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

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
            cell.configureCell(model: model)
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

// MARK: - Extension ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func configureAlert() {
        let alertController = UIAlertController(
            title: AppConstants.changeAlertTitle,
            message: nil,
            preferredStyle: .alert
        )
        let actionCancel = UIAlertAction(title: "Отмена", style: .default)
        let actionOk = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addTextField { title in
            title.placeholder = AppConstants.placeholderText
        }
        alertController.addAction(actionCancel)
        alertController.addAction(actionOk)
        present(alertController, animated: true)
    }
}
