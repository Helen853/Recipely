// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с избранным
final class FavoritesViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Favorites"
        static let foodCellIdentifier = "FoodCell"
        static let cellHeight = 125
        static let countShimmerRows = 4
        static let basketViewTitle = "There's nothing here yet"
        static let basketViewText = "Add interesting recipes to make ordering products convenient"
        static let basketViewImageName = "emptyFavorites"
    }

    // MARK: - Visual Components

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Public Properties

    var favorites: [Recipes] = []
    var fvoritesPresenter: FavoritesPresenterProtocol?

    // MARK: - Private Properties

    private var basketView = BasketView(
        frame: .zero,
        title: Constants.basketViewTitle,
        text: Constants.basketViewText,
        image: UIImage(named: Constants.basketViewImageName) ?? UIImage()
    )
    private var state: StateLoaded = .loading

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupTableView()
        setupBasketViewAnchors()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoadedTableView()
        favorites = FavoritesService.shared.load()
        fvoritesPresenter?.returnFavorites()
    }

    // MARK: - Private Methods

    private func setupNavigationItems() {
        view.backgroundColor = .white
        navigationItem.title = Constants.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FoodCell.self, forCellReuseIdentifier: Constants.foodCellIdentifier)
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func showLoadedTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.state = .loaded
            self?.tableView.reloadData()
        }
    }

    private func setupBasketViewAnchors() {
        basketView.isHidden = false
        view.addSubview(basketView)
        basketView.translatesAutoresizingMaskIntoConstraints = false
        basketView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        basketView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        basketView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

/// FavoritesViewController + UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {}

/// FavoritesViewController + UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return Constants.countShimmerRows
        case .loaded:
            return favorites.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loading:
            tableView.isScrollEnabled = false
            return ShimmerRecipeTableViewCell()
        case .loaded:
            tableView.isScrollEnabled = true
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.foodCellIdentifier,
                for: indexPath
            ) as? FoodCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.nextButton.isHidden = true
            cell.configure(with: favorites[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(Constants.cellHeight)
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            FavoritesService.shared.removeFavorites(indexPath.row)
        }

        if favorites.isEmpty {
            basketView.isHidden = false
        }
    }
}

/// FavoritesViewController + FavoritesViewControllerProtocol
extension FavoritesViewController: FavoritesViewControllerProtocol {
    /// Обновление избранных рецептов
    /// - Parametr: массив с рецептами
    func uppdateFavorites(_ favorites: [Recipes]) {
        uppdateViewHidden()
        self.favorites = favorites
        tableView.reloadData()
    }

    /// Появление вью если в избранном пусто
    func uppdateViewHidden() {
        basketView.isHidden = !FavoritesService.shared.favorites.isEmpty
    }
}
