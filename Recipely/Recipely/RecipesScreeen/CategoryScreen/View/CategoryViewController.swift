// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран категорий
final class CategoryViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let fontVerdanaBold = "Verdana-Bold"
        static let backButtonImagename = "Arrow"
        static let serchPlaceholder = "Search recipes"
        static let searchImageName = "search"
        static let caloriesButtonTitle = "Calories"
        static let caloriesButtonImageNameOne = "CaloriesImage"
        static let caloriesButtonImageNameTwo = "caloriesImageTwo"
        static let caloriesButtonImageNameThree = "CaloriesImageThree"
        static let timeButtonTitle = "Time"
        static let foodCellIdentifier = "FoodCell"
        static let heightcFoodCell = 125
    }

    var tappedNextHandler: VoidHandler?

    // MARK: - Visual Components

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = Constants.serchPlaceholder
        search.backgroundImage = UIImage()
        return search
    }()

    private let searchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.searchImageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var caloriesButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.caloriesButtonTitle, for: .normal)
        button.setImage(UIImage(named: Constants.caloriesButtonImageNameOne), for: .normal)
        button.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
        button.titleLabel?.font = UIFont(name: Constants.fontVerdana, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTappedCalories), for: .touchUpInside)
        return button
    }()

    lazy var timeButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.timeButtonTitle, for: .normal)
        button.setImage(UIImage(named: Constants.caloriesButtonImageNameOne), for: .normal)
        button.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
        button.titleLabel?.font = UIFont(name: Constants.fontVerdana, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTappedTimer), for: .touchUpInside)
        return button
    }()

    // MARK: - Puplic Properties

    var titleScreen: String?
    var isDataLoaded = false
    var categoryPresenter: CategoryPresenterProtocol?
    var recipes: [Recipes] = []

    // MARK: - Private Properties

    private lazy var items: [CellTypes] = [
        .foods(recipes)
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAnchors()
        setupTableView()
        tappedNextButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoadedTableView()
    }

    // MARK: - Public Methods

    func setupCategory(_ type: CategoryCellType) {
        categoryPresenter?.returnRecipes(type)
    }

    // MARK: - Private Methods

    private func tappedNextButton() {
        tappedNextHandler = { [weak self] in
            guard let self = self else { return }
            categoryPresenter?.showRecipeDetail()
        }
    }

    private func showLoadedTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.isDataLoaded = true
            self?.tableView.reloadData()
        }
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(caloriesButton)
        view.addSubview(timeButton)
        view.addSubview(searchBar)
    }

    private func setupAnchors() {
        setupAnchorsSearchBar()
        setupAnchorsCaloriesButton()
        setupAnchorsTimeButton()
    }

    private func setupAnchorsSearchBar() {
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 335).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func setupAnchorsCaloriesButton() {
        caloriesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        caloriesButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        caloriesButton.widthAnchor.constraint(equalToConstant: 112).isActive = true
        caloriesButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func setupAnchorsTimeButton() {
        timeButton.leadingAnchor.constraint(equalTo: caloriesButton.trailingAnchor, constant: 11).isActive = true
        timeButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        timeButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        timeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func setupTableView() {
        tableView.register(FoodCell.self, forCellReuseIdentifier: Constants.foodCellIdentifier)
        tableView.register(ShimmerRecipeTableViewCell.self, forCellReuseIdentifier: AppConstants.shimmerIdentifier)
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: caloriesButton.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupNavigationItem() {
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constants.fontVerdanaBold, size: 24) ?? UIFont(),
            .foregroundColor: UIColor.black
        ]

        let backButton = UIBarButtonItem(
            image: UIImage(named: Constants.backButtonImagename),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        backButton.tintColor = .black

        let titleButton = UIBarButtonItem(title: titleScreen, style: .plain, target: self, action: nil)
        titleButton.tintColor = .black
        titleButton.setTitleTextAttributes(textAttributes, for: .normal)
        navigationItem.leftBarButtonItems = [backButton, titleButton]
    }

    @objc private func goBack() {
        categoryPresenter?.goBackRecipesScreen()
    }

    @objc private func buttonTappedCalories() {
        categoryPresenter?.updateSortingStateCaloriesButton()
    }

    @objc private func buttonTappedTimer() {
        categoryPresenter?.updateSortingStateTimeButton()
    }
}

/// CategoryViewController + UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {}

/// CategoryViewController + UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isDataLoaded {
            let item = items[indexPath.section]
            switch item {
            case let .foods(info):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.foodCellIdentifier,
                    for: indexPath
                ) as? FoodCell
                else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(with: info[indexPath.row], handler: tappedNextHandler)
                return cell
            }
        } else {
            return ShimmerRecipeTableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.section]
        switch item {
        case .foods:
            return CGFloat(Constants.heightcFoodCell)
        }
    }
}

/// CategoryViewController + CategoryViewControllerProtocol
extension CategoryViewController: CategoryViewControllerProtocol {
    func updateButtonTimer(_ state: SortingState) {
        switch state {
        case .none:
            timeButton.setTitle(Constants.timeButtonTitle, for: .normal)
            timeButton.setImage(UIImage(named: Constants.caloriesButtonImageNameOne), for: .normal)
            timeButton.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
            timeButton.setTitleColor(.black, for: .normal)
        case .up:
            timeButton.setTitle(Constants.timeButtonTitle, for: .normal)
            timeButton.setImage(UIImage(named: Constants.caloriesButtonImageNameTwo), for: .normal)
            timeButton.backgroundColor = UIColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1.0)
            timeButton.setTitleColor(.white, for: .normal)
        case .down:
            timeButton.setTitle(Constants.timeButtonTitle, for: .normal)
            timeButton.setImage(UIImage(named: Constants.caloriesButtonImageNameThree), for: .normal)
            timeButton.backgroundColor = UIColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1.0)
            timeButton.setTitleColor(.white, for: .normal)
        }
    }

    func updateButtonCalories(_ state: SortingState) {
        switch state {
        case .none:
            caloriesButton.setTitle(Constants.caloriesButtonTitle, for: .normal)
            caloriesButton.setImage(UIImage(named: Constants.caloriesButtonImageNameOne), for: .normal)
            caloriesButton.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
            caloriesButton.setTitleColor(.black, for: .normal)
        case .up:
            caloriesButton.setTitle(Constants.caloriesButtonTitle, for: .normal)
            caloriesButton.setImage(UIImage(named: Constants.caloriesButtonImageNameTwo), for: .normal)
            caloriesButton.backgroundColor = UIColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1.0)
            caloriesButton.setTitleColor(.white, for: .normal)
        case .down:
            caloriesButton.setTitle(Constants.caloriesButtonTitle, for: .normal)
            caloriesButton.setImage(UIImage(named: Constants.caloriesButtonImageNameThree), for: .normal)
            caloriesButton.backgroundColor = UIColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 1.0)
            caloriesButton.setTitleColor(.white, for: .normal)
        }
    }

    // Обновляется массив с рецептами и название экрана
    // - Parametr: массив рецептов
    // - Parametr: тайтл для навигейшенБара
    func uppdateRecipes(_ recipes: [Recipes], _ title: String) {
        self.recipes = recipes
        titleScreen = title
        setupNavigationItem()
        tableView.reloadData()
    }
}
