// UserCaretaker.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Caretaker User
final class UserCaretaker {
    // MARK: - Constants

    private enum Constants {
        static let key = "user_memento"
    }

    // MARK: - Private Properties

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Public Methods

    // Метод для сохранения снимка состояния пользователя
    func saveMemento(_ memento: UserMemento) {
        do {
            let data = try encoder.encode(memento)
            UserDefaults.standard.set(data, forKey: Constants.key)
        } catch {
            print(error)
        }
    }

    // Метод для восстановления снимка состояния пользователя
    func retrieveMemento() -> UserMemento? {
        guard let data = UserDefaults.standard.data(forKey: Constants.key) else { return nil }
        do {
            return try decoder.decode(UserMemento.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
