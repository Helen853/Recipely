// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для экрана профиля
protocol ProfileViewProtocol: AnyObject {
    /// настройка алерта
    func configureAlert()
    /// изменение имени пользователя в профиле
    /// -Parametr: новое имя
    func changeLabel(updateName: String)
    /// установка вью с условиями политики
    func setupTermsPolicy()
    func removeTerms()
    func removeVisualEffect()
    func animateTransition(state: TermsState, duration: TimeInterval)
}

/// Экран профиля пользователя
final class ProfileViewController: UIViewController {
    // MARK: - Visual Components

    private let tableView = UITableView()
    private let visualEffectView = UIVisualEffectView()
    private let termsHieght: CGFloat = 760
    private let termsHandleArea: CGFloat = 300

    // MARK: - Public Properties

    var profilePresenter: ProfilePresenter?
    var termsView: TermsPolicyView?
    var onTapHandler: VoidHandler?
    var arrowTapHandler: VoidHandler?
    var termsTapHandler: VoidHandler?

    // MARK: - Private Properties

    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var animationProgressWhenInterputted: CGFloat = 0
    private var isVisible = true
    private var nextState: TermsState {
        isVisible ? .collapsed : .expanded
    }

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
        onTapChangeName()
        arrowButtonTapped()
        termsButtonTapped()
    }

    // MARK: - Private Methods

    private func onTapChangeName() {
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

    private func setupVisualEffect() {
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        let darkAnimator = UIViewPropertyAnimator(duration: 0.9, dampingRatio: 1)
        visualEffectView.effect = UIBlurEffect(style: .dark)
        darkAnimator.startAnimation()
        runningAnimations.append(darkAnimator)
    }

    private func startInteractiveTransition(state: TermsState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransition(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterputted = animator.fractionComplete
        }
    }

    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterputted
        }
    }

    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
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

    /// настройка вью конфиденциальности
    func setupTermsPolicy() {
        termsView = TermsPolicyView()
        guard let termsView = termsView else { return }
        termsView.frame = CGRect(
            x: 0,
            y: view.frame.height - termsHandleArea,
            width: view.frame.width,
            height: termsHieght
        )
        termsView.clipsToBounds = true
        let scene = UIApplication.shared.connectedScenes
        let windowScene = scene.first as? UIWindowScene
        windowScene?.windows.last?.addSubview(termsView)

        // устанавливааем распознователь жестов на вью c условиями
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(tapScreenTerms))
        termsView.addGestureRecognizer(panGestureRecognizer)
        profilePresenter?.addVisualEffect()
    }

    @objc func tapScreenTerms(recognizer: UIPanGestureRecognizer) {
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

    /// Анимация переходов
    /// -Parametr: state -состояние вью "политики конфиденциальности", duration - продолжительность
    func animateTransition(state: TermsState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .started:
                    self.termsView?.frame.origin.y = self.view.frame.height - self.termsHandleArea
                case .expanded:
                    self.termsView?.frame.origin.y = self.view.frame.height - self.termsHieght
                case .collapsed:
                    self.termsView?.frame.origin.y = self.view.frame.height - self.termsHandleArea
                    self.profilePresenter?.removeTermsPolicy()
                }
            }

            frameAnimator.addCompletion { _ in
                self.isVisible = !self.isVisible
                self.runningAnimations.removeAll()
            }

            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            setupVisualEffect()
        }
    }

    /// удаление экрана с условиями
    func removeTerms() {
        termsView?.removeFromSuperview()
    }

    /// удаление визуального эффекта с вью
    func removeVisualEffect() {
        visualEffectView.removeFromSuperview()
    }
}
