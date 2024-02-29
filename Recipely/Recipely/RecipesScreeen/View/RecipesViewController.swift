// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран рецептов
final class RecipesViewController: UIViewController {
    var recipesPresenter: RecipesPresenter?
    var categoryTapHandler: VoidHandler?

    private var categories: [Category] = [
        Category(
            cellType: .medium,
            imageName: AppConstants.salad,
            categoryName: AppConstants.salad,
            hightTitle: 30,
            sizeText: 20
        ),
        Category(
            cellType: .medium,
            imageName: AppConstants.soup,
            categoryName: AppConstants.soup,
            hightTitle: 30,
            sizeText: 20
        ),
        Category(
            cellType: .large,
            imageName: AppConstants.chicken,
            categoryName: AppConstants.chicken,
            hightTitle: 50,
            sizeText: 20
        ),
        Category(
            cellType: .small,
            imageName: AppConstants.meat,
            categoryName: AppConstants.meat,
            hightTitle: 28.6,
            sizeText: 16
        ),
        Category(
            cellType: .small,
            imageName: AppConstants.fish,
            categoryName: AppConstants.fish,
            hightTitle: 28.6,
            sizeText: 16
        ),
        Category(
            cellType: .small,
            imageName: AppConstants.sideDish,
            categoryName: AppConstants.sideDish,
            hightTitle: 28.6,
            sizeText: 16
        ),
        Category(
            cellType: .large,
            imageName: AppConstants.drinks,
            categoryName: AppConstants.drinks,
            hightTitle: 50,
            sizeText: 20
        ),
        Category(
            cellType: .medium,
            imageName: AppConstants.pancake,
            categoryName: AppConstants.pancake,
            hightTitle: 30,
            sizeText: 20
        ),
        Category(
            cellType: .medium,
            imageName: AppConstants.desserts,
            categoryName: AppConstants.desserts,
            hightTitle: 30,
            sizeText: 20
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollection()
        categoryTapped()
    }

    private func categoryTapped() {
        categoryTapHandler = { [weak self] in
            guard let self = self else { return }
            recipesPresenter?.openCell()
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
        // layout.minimumInteritemSpacing = 10
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
        let type = categories[indexPath.item].cellType

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
