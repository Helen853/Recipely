// UserOriginator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура которая управляет сохранинем и восстановлением состояния пользователя
struct UserOriginator {
    // MARK: - Constants

    private enum Constants {
        static let key = "user_memento"
        static let keyImage = "AvatarImageData"
    }

    // MARK: - Public Properties

    static var shared = UserOriginator(user: User(email: "", surname: ""))

    // MARK: - Private Properties

    private let userDefaults = UserDefaults.standard
    private var user: User

    // MARK: - Public Methods

    /// Обновление информации о пользователе
    mutating func updateUser(_ updatedUser: User) {
        user.email = updatedUser.email
//        user.password = updatedUser.password
        user.surname = updatedUser.surname
        saveToUserDefaults()
    }

    /// Сохранение состояния пользователя
    func saveToMemento() -> UserMemento {
        UserMemento(user: user)
    }

    /// Восстановление состояние пользователя
    mutating func restoreFromMemento(_ memento: UserMemento) {
        user = memento.user
        saveToUserDefaults()
    }

    /// Обновления имени фамилии пользователя
    mutating func updateNickname(_ newNickname: String) {
        user.surname = newNickname
        saveToUserDefaults()
    }

    /// Сохранение в UserDefaults
    func saveToUserDefaults() {
        do {
            let encodedData = try JSONEncoder().encode(user)
            userDefaults.set(encodedData, forKey: Constants.key)
        } catch {
            print(error)
        }
    }

    /// Загрузка из UserDefaults
    func loadFromUserDefaults() -> User? {
        guard let encodedData = userDefaults.data(forKey: Constants.key) else { return nil }
        do {
            return try JSONDecoder().decode(User.self, from: encodedData)
        } catch {
            print(error)
            return nil
        }
    }

    mutating func loadUser() -> User {
        guard let loadUser = loadFromUserDefaults() else { return User(email: "", surname: "") }
        user = loadUser
        return loadUser
    }

    // сохранение картинки
    func saveImageInUserDefaults(data: Data) {
        do {
            let encoded = try PropertyListEncoder().encode(data)
            userDefaults.set(encoded, forKey: Constants.keyImage)
        } catch {
            print(error)
        }
    }

    // получение картинки
    func getImageDataFromUserDefaults() -> Data? {
        guard let data = userDefaults.data(forKey: Constants.keyImage),
              let decoded = try? PropertyListDecoder().decode(Data.self, from: data)
        else { return nil }
        return decoded
    }
}
