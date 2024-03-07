// UserCaretaker.swift
// Copyright © RoadMap. All rights reserved.

//
//  Caretaker.swift
//  Recipely
//
//  Created by mac on 07.03.2024.
//
import UIKit

/// Caretaker User
class UserCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "user_memento"

    // Метод для сохранения снимка состояния пользователя
    func saveMemento(_ memento: UserMemento) {
        do {
            let data = try encoder.encode(memento)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    // Метод для восстановления снимка состояния пользователя
    func retrieveMemento() -> UserMemento? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            return try decoder.decode(UserMemento.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
