// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран категорий
final class CategoryViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
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
        static let countShimmerRows = 4
        static let searchAfterCount = 3
        static let notFoundViewTitle = "Nothing found"
        static let notFoundViewText = "Try entering your query differently"
        static let notFoundViewImageName = "search2"
    }

    // MARK: - Visual Components

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = Constants.serchPlaceholder
        search.backgroundImage = UIImage()
        search.delegate = self
        return search
    }()

    private let searchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.searchImageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var caloriesButton: UIButton = makeSortingButton(
        title: Constants.caloriesButtonTitle,
        image: UIImage(named: Constants.caloriesButtonImageNameOne) ?? UIImage(),
        action: #selector(buttonTappedCalories)
    )

    private lazy var timeButton: UIButton = makeSortingButton(
        title: Constants.timeButtonTitle,
        image: UIImage(named: Constants.caloriesButtonImageNameOne) ?? UIImage(),
        action: #selector(buttonTappedTimer)
    )

    // MARK: - Puplic Properties

    static var shared = CategoryViewController()

    var categoryPresenter: CategoryPresenterProtocol?
    var recipes: [Recipes] = []

    // MARK: - Private Properties

    private var notFoundView = BasketView(
        frame: .zero,
        title: Constants.notFoundViewTitle,
        text: Constants.notFoundViewText,
        image: UIImage(named: Constants.notFoundViewImageName) ?? UIImage()
    )
    private var searchidgRecipes: [Recipes] = []
    private var titleScreen: String?
    private var isDataLoaded = false
    private var searching = false
    private var state: StateLoaded = .loading
    private var logger = LoggerInvoker()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAnchors()
        setupTableView()
        categoryPresenter?.changeState()
    }

    override func viewWillAppear(_ animated: Bool) {
        makeLog()
    }

    // MARK: - Public Methods

    func setupCategory(_ type: DishType) {
        categoryPresenter?.returnRecipes(type)
    }

    // MARK: - Private Methods

    private func makeLog() {
        logger.log(actionUser: .openRecipe)
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(caloriesButton)
        view.addSubview(timeButton)
        view.addSubview(searchBar)
        tableView.addSubview(notFoundView)
    }

    private func setupAnchors() {
        setupAnchorsSearchBar()
        setupAnchorsCaloriesButton()
        setupAnchorsTimeButton()
        setupNotFoundView()
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
        timeButton.widthAnchor.constraint(equalToConstant: 112).isActive = true
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

    private func setupNotFoundView() {
        notFoundView.isHidden = true
        notFoundView.translatesAutoresizingMaskIntoConstraints = false
        notFoundView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        notFoundView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: -200).isActive = true
    }

    private func setupNavigationItem() {
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: .verdanaBold24 ?? UIFont(),
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

    private func makeSortingButton(title: String, image: UIImage, action: Selector) -> UIButton {
        let button = StateButton(
            title: title,
            image: image
        )
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    @objc private func goBack() {
        categoryPresenter?.goBackRecipesScreen()
    }

    @objc private func buttonTappedCalories() {
        categoryPresenter?.buttonCaloriesChange(category: CategoryViewController.shared.recipes)
    }

    @objc private func buttonTappedTimer() {
        categoryPresenter?.buttonTimeChange(category: CategoryViewController.shared.recipes)
    }
}

/// CategoryViewController + UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelRecipes = CategoryViewController.shared.recipes[indexPath.row]
        categoryPresenter?.returnModel(model: modelRecipes)
    }
}

/// CategoryViewController + UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return Constants.countShimmerRows
        case .loaded:
            if searching {
                return searchidgRecipes.count
            } else {
                return CategoryViewController.shared.recipes.count
            }
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
            if searching {
                cell.configure(with: searchidgRecipes[indexPath.row])
            } else {
                cell.configure(with: CategoryViewController.shared.recipes[indexPath.row])
            }

            categoryPresenter?.getImage(index: indexPath.row, handler: { data in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    cell.configureImage(image: image)
                }
            })
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(Constants.heightcFoodCell)
    }
}

/// CategoryViewController + CategoryViewControllerProtocol
extension CategoryViewController: CategoryViewControllerProtocol {
    func succes() {
        tableView.reloadData()
    }

    func failure(error: Error) {
        print(error)
    }

    func changeState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.state = .loaded
            self?.tableView.reloadData()
        }
    }

    func buttonCaloriesState(color: String, image: String) {
        caloriesButton.backgroundColor = UIColor(named: color)
        caloriesButton.setImage(UIImage(named: image), for: .normal)
    }

    func buttonTimeState(color: String, image: String) {
        timeButton.backgroundColor = UIColor(named: color)
        timeButton.setImage(UIImage(named: image), for: .normal)
    }

    func sortedRecip(recipe: [Recipes]) {
        CategoryViewController.shared.recipes = recipe
        tableView.reloadData()
    }

    // Обновляется массив с рецептами и название экрана
    // - Parametr: массив рецептов
    // - Parametr: тайтл для навигейшенБара
    func uppdateRecipes(_ recipes: [Recipes], _ title: String) {
        CategoryViewController.shared.recipes = recipes
        titleScreen = title
        setupNavigationItem()
        tableView.reloadData()
    }
}

/// CategoryViewController + UISearchBarDelegate
extension CategoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > Constants.searchAfterCount {
            searchidgRecipes = CategoryViewController.shared.recipes
                .filter { $0.foodName.prefix(searchText.count) == searchText }
            notFoundView.isHidden = !searchidgRecipes.isEmpty
            searching = true
            tableView.reloadData()
        } else {
            searching = false
            notFoundView.isHidden = true
            tableView.reloadData()
        }
    }
}
