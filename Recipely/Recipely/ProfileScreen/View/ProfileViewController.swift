// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для экрана профиля
protocol ProfileViewProtocol: AnyObject {
    func configureAlert()
    func changeLabel(updateName: String)
    func setupTerms()
}

/// Экран профиля пользователя
final class ProfileViewController: UIViewController {
    // MARK: - Visual Components

    private let tableView = UITableView()
    private let visualEffectView = UIVisualEffectView()

    // MARK: - Public Properties

    var profilePresenter: ProfilePresenter?
    var termsPolicyViewController: TermsPolicyViewController?
    var termsView: TermsPolicyView?
    let termsHieght: CGFloat = 760
    let termsHandleArea: CGFloat = 300
    var isVisible = false
    var nextState: TermsState {
        isVisible ? .collapsed : .expanded
    }

    var animationProgressWhenInterputted: CGFloat = 0

    var onTapHandler: VoidHandler?
    var arrowTapHandler: VoidHandler?
    var termsTapHandler: VoidHandler?
    var runningAnimations: [UIViewPropertyAnimator] = []

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
        termsButtonTapped()
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

    private func termsButtonTapped() {
        termsTapHandler = { [weak self] in
            guard let self = self else { return }
            profilePresenter?.showTermsPolicy()
        }
    }

    private func configureTitle() {
        navigationItem.title = AppConstants.profile
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTable() {
        tableView.separatorStyle = .none
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
            cell.configureCell(model: model, tapButton: termsTapHandler)
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

    //
    func setupTerms() {
        // Задаем эффект для экрана профиля
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)

        // настройка экрана политики конфиденциальности
//        termsPolicyViewController = TermsPolicyViewController()
//        guard let termsPolicyViewController = termsPolicyViewController else { return }
//        tabBarController?.tabBar.isHidden = true
//        view.addSubview(termsPolicyViewController.view)
//        addChild(termsPolicyViewController)
//        termsPolicyViewController.didMove(toParent: self)
//
        termsView = TermsPolicyView()
        guard let termsView = termsView else { return }
        termsView.frame = CGRect(
            x: 0,
            y: view.frame.height - termsHandleArea,
            width: view.frame.width,
            height: termsHieght
        )

        termsView.clipsToBounds = true
        view.addSubview(termsView)

        // устанавливааем распознователь жестов
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panScreenTerms))
        termsView.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func panScreenTerms(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: termsView)
            var fractionComplete = translation.y / termsHieght
            fractionComplete = isVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }

    func animateTransitionNeeded(state: TermsState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.termsView?.frame.origin.y = self.view.frame.height - self.termsHieght
                case .collapsed:
                    self.termsView?.frame.origin.y = self.view.frame.height - self.termsHandleArea
                }
            }

            frameAnimator.addCompletion { _ in
                self.isVisible = !self.isVisible
                self.runningAnimations.removeAll()
            }

            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)

            let darkAnimator = UIViewPropertyAnimator(duration: 0.9, dampingRatio: 1)
            visualEffectView.effect = UIBlurEffect(style: .dark)
            darkAnimator.startAnimation()
            runningAnimations.append(darkAnimator)
        }
    }

    func startInteractiveTransition(state: TermsState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterputted = animator.fractionComplete
        }
    }

    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterputted
        }
    }

    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
