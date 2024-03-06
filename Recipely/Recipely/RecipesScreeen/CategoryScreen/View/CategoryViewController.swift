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

    lazy var caloriesButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.caloriesButtonTitle, for: .normal)
        button.setImage(UIImage(named: Constants.caloriesButtonImageNameOne), for: .normal)
        button.backgroundColor = .grayForGround
        button.titleLabel?.font = .verdana16
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
        button.backgroundColor = .grayForGround
        button.titleLabel?.font = .verdana16
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTappedTimer), for: .touchUpInside)
        return button
    }()

    // MARK: - Puplic Properties

    var tappedNextHandler: VoidHandler?
    var categoryPresenter: CategoryPresenterProtocol?

    // MARK: - Private Properties

    private var notFoundView = BasketView(
        frame: .zero,
        title: "Nothing found",
        text: "Try entering your query differently",
        image: UIImage(named: "search2") ?? UIImage()
    )
  private var recipes: [Recipes] = []
  private var searchidgRecipes: [Recipes] = []
  private var titleScreen: String?
    private var isDataLoaded = false
    private var searching = false
    private var state: StateLoaded = .loading

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAnchors()
        setupTableView()
        tappedNextButton()
        categoryPresenter?.changeState()
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

    @objc private func goBack() {
        categoryPresenter?.goBackRecipesScreen()
    }

    @objc private func buttonTappedCalories() {
        categoryPresenter?.buttonCaloriesChange(category: recipes)
    }

    @objc private func buttonTappedTimer() {
        categoryPresenter?.buttonTimeChange(category: recipes)
    }
}

/// CategoryViewController + UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {}

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
                return recipes.count
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
                cell.configure(with: searchidgRecipes[indexPath.row], handler: tappedNextHandler)
            } else {
                cell.configure(with: recipes[indexPath.row], handler: tappedNextHandler)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(Constants.heightcFoodCell)
    }
}

/// CategoryViewController + CategoryViewControllerProtocol
extension CategoryViewController: CategoryViewControllerProtocol {
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
        recipes = recipe
        tableView.reloadData()
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

extension CategoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > Constants.searchAfterCount {
            searchidgRecipes = recipes.filter { $0.foodName.prefix(searchText.count) == searchText }
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
