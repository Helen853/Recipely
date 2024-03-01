// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для экрана рецептов
protocol RecipesViewControllerProtocol: AnyObject {
    /// Загрузка  коллекции
    ///  -   Parametr: массив с данными
    func loadCollection(categories: [Category])
}

/// Экран рецептов
final class RecipesViewController: UIViewController {
    // MARK: - Public Properties

    // Массив с моделями ячеек категорий
    var categories: [Category] = []
    var recipesPresenter: RecipesPresenter?
    var categoryTapHandler: ((_ type: CategoryCellType) -> ())?

    // MARK: - Private Properties

    private let info = InfoCategory()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        recipesPresenter?.loadCell(model: info.categories)
        configureCollection()
        categoryTapped()
    }

    // MARK: - Private Methods

    private func categoryTapped() {
        categoryTapHandler = { [weak self] type in
            guard let self = self else { return }
            recipesPresenter?.openCell(type: type)
        }
    }

    private func configureNavigationBar() {
        navigationItem.title = AppConstants.recipes
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureCollection() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: AppConstants.recipesIdentifier
        )
    }

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        return layout
    }
}

// MARK: - Extension RecipesViewController + UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AppConstants.recipesIdentifier,
            for: indexPath
        ) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(model: categories[indexPath.item], handler: categoryTapHandler)
        return cell
    }
}

// MARK: - Extension RecipesViewController + UICollectionViewDelegateFlowLayout

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let type = categories[indexPath.item].sizeType

        switch type {
        case .small:
            let sizeCell = (UIScreen.main.bounds.width - 60) / 3
            return CGSize(width: sizeCell, height: sizeCell)
        case .medium:
            let sizeCell = (UIScreen.main.bounds.width - 40) / 2
            return CGSize(width: sizeCell, height: sizeCell)
        case .large:
            return CGSize(width: 250, height: 250)
        }
    }
}

// MARK: - Extension RecipesViewController + RecipesViewControllerProtocol

extension RecipesViewController: RecipesViewControllerProtocol {
    /// Загрузка  коллекции
    ///  -   Parametr: массив с данными
    func loadCollection(categories: [Category]) {
        self.categories = categories
    }
}
