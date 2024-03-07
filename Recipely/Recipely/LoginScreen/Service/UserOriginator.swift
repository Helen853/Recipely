// UserOriginator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура которая управляет сохранинем и восстановлением состояния пользователя
struct UserStateWrapper {
  
  private enum Constants {
    static let key = "user_memento"
    static let keyImage = "AvatarImageData"
  }
  
    static var shared = UserStateWrapper(user: User(email: "", password: "", surname: ""))
    private let userDefaults = UserDefaults.standard
    private var user: User

    //  init(load: loadFromUserDefaults) {
//        self.user = user
//    }

    /// Обновление информации о пользователе
    mutating func updateUser(_ updatedUser: User) {
        user.email = updatedUser.email
        user.password = updatedUser.password
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
        guard let loadUser = loadFromUserDefaults() else { return User(email: "", password: "", surname: "") }
        user = loadUser
        return loadUser
    }

    // сохранение картинки
    func saveImageInUserDefaults(data: Data) {
        let encoded = try? PropertyListEncoder().encode(data)
      userDefaults.set(encoded, forKey: Constants.keyImage)
    }

    // получение картинки
    func getImageDataFromUserDefaults() -> Data? {
        guard
          let data = UserDefaults.standard.data(forKey: Constants.keyImage),
            let decoded = try? PropertyListDecoder().decode(Data.self, from: data)
        else { return nil }
        return decoded
    }
}
