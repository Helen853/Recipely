// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля пользователя
class ProfileViewController: UIViewController {
    var profilePresenter: ProfilePresenter?
    private let tableView = UITableView()

    // Массив с моделями ячеек
    private var cells: [CellTypeProtocol] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
    }

    private func configureTitle() {
        navigationItem.title = AppConstants.profile
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTable() {
        view.addSubview(tableView)
        // tableView.delegate = self
        tableView.dataSource = self
        // tableView.estimatedRowHeight = 144
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
            ItemTableViewCell.self,
            forCellReuseIdentifier: AppConstants.infoIdentifier
        )
    }
}

// MARK: - Extension UITableViewDataSource

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
            cell.configureCell(model: model)
            return cell
        case .item:
            guard
                let cell = tableView
                .dequeueReusableCell(withIdentifier: AppConstants.itemIdentifier) as? ItemTableViewCell,
                let model = cells[indexPath.row] as? Item
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
        }
    }
}
