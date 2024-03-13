// RecipeDetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для экрана с детальным рецептом
protocol RecipeDetailViewControllerProtocol: AnyObject {
    /// Загрузка  таблицы
    func loadTable(details: [RecipeDetailProtocol])
    /// Обновление кнопки сохранить в избранное
    func updateSaveButton(state: SaveButtonState)
    /// Появление уведомления о добавлении в избранное
    func showAddFavoritesLabel()
    /// Исчезновение уведомления о добавлении в избранное
    func removeLabel()
    /// Отправить рецепт в телеграмм
    func shareRecipe(text: String)
    /// Настройка кнопки "Сохранить в избранное"
    func setupSaveButton(title: String?)
    /// Настройка ячейки
    func setupCell(model: Recipes)
    ///
    func succes()
    ///
    func failure(error: Error)
}

/// Экран подробного рецепта
final class RecipeDetailViewController: UIViewController {
    // MARK: - Public Properties

    var recipeDetailPresenter: RecipeDetailPresenter?

    // MARK: - Visual Components

    private let tableView = UITableView()
    private let backButton = UIButton()
    private let shareButton = UIButton()
    private let saveButton = UIButton()
    private let addFavoritesLabel = UILabel()
    private let storageDetail = RecipeDetail()
    private var details: [RecipeDetailProtocol] = []
    private var logger = LoggerInvoker()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configNavigationBar()
        configureTable()
        registerCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        makeLog()
    }

    // MARK: - Private Methods

    private func makeLog() {
        logger.log(actionUser: .openRecipeDetail)
    }

    private func configNavigationBar() {
        backButton.setImage(UIImage(named: AppConstants.back), for: .normal)
        shareButton.setImage(UIImage(named: AppConstants.share), for: .normal)
        saveButton.setImage(UIImage(named: AppConstants.save), for: .normal)
        let rightButtonItem = UIBarButtonItem(customView: saveButton)
        let secondRightButtonItem = UIBarButtonItem(customView: shareButton)
        navigationItem.setRightBarButtonItems([rightButtonItem, secondRightButtonItem], animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        backButton.addTarget(self, action: #selector(tappedBack), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(tappedSave), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(tappedShare), for: .touchUpInside)
    }

    private func configureView() {
        view.backgroundColor = .white
    }

    private func configureTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func registerCell() {
        tableView.register(
            ImageTableViewCell.self,
            forCellReuseIdentifier: AppConstants.imageIdentifier
        )
        tableView.register(
            InfoRecipeTableViewCell.self,
            forCellReuseIdentifier: AppConstants.infoRecipeIdentifier
        )
        tableView.register(
            TextTableViewCell.self,
            forCellReuseIdentifier: AppConstants.textIdentifier
        )
    }

    @objc private func tappedBack() {
        recipeDetailPresenter?.showCategory()
    }

    @objc private func tappedSave() {
        guard let title = (details[0] as? Image)?.title else { return }
        recipeDetailPresenter?.updateColorButton(title: title)
    }

    @objc private func tappedShare() {
        recipeDetailPresenter?.shareRecipeText()
        logger.log(actionUser: .shareRecipe)
    }
}

// MARK: - Extension RecipeDetailViewController + UITableViewDataSource

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = details[indexPath.row].cellType

        switch cellType {
        case .image:
            guard
                let cell = tableView
                .dequeueReusableCell(withIdentifier: AppConstants.imageIdentifier) as? ImageTableViewCell,
                let model = details[indexPath.row] as? Image
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
        case .info:
            guard
                let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: AppConstants
                        .infoRecipeIdentifier
                ) as? InfoRecipeTableViewCell,
                let model = details[indexPath.row] as? InfoRecipe
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
        case .text:
            guard
                let cell = tableView
                .dequeueReusableCell(withIdentifier: AppConstants.textIdentifier) as? TextTableViewCell,
                let model = details[indexPath.row] as? Text
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
        }
    }
}

// MARK: - Extension RecipeDetailViewController + RecipeDetailViewControllerProtocol

extension RecipeDetailViewController: RecipeDetailViewControllerProtocol {
    func succes() {
        tableView.reloadData()
    }

    func failure(error: Error) {
        print(error)
    }

    /// Загрузка  таблицы
    ///  -   Parametr: массив с данными
    func loadTable(details: [RecipeDetailProtocol]) {
        self.details = details
    }

    /// Отправить рецепт в телеграмм
    ///  -   Parametr: текст рецепта
    func shareRecipe(text: String) {
        let textToShare = [text]
        let activity = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }

    /// Появление уведомления о добавлении в избранное
    func showAddFavoritesLabel() {
        addFavoritesLabel.text = AppConstants.addFavoritesText
        addFavoritesLabel.font = .verdana16
        addFavoritesLabel.textAlignment = .center
        addFavoritesLabel.textColor = .white
        addFavoritesLabel.clipsToBounds = true
        addFavoritesLabel.backgroundColor = .black
        addFavoritesLabel.layer.cornerRadius = 12
        view.addSubview(addFavoritesLabel)
        addFavoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        addFavoritesLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        addFavoritesLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        addFavoritesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addFavoritesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
    }

    /// Исчезновение уведомления о добавлении в избранное
    func removeLabel() {
        addFavoritesLabel.removeFromSuperview()
    }

    /// Обновление кнопки сохранить в избранное
    ///  -   Parametr: состояние кнопки
    func updateSaveButton(state: SaveButtonState) {
        switch state {
        case .red:
            saveButton.backgroundColor = .redForButton
        case .clear:
            saveButton.backgroundColor = .clear
        }
    }

    func setupSaveButton(title: String?) {
        recipeDetailPresenter?.setupSaveButton(title: title)
    }

    func setupCell(model: Recipes) {
        recipeDetailPresenter?.loadCell(recipe: model)
    }
}
