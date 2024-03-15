// ProxyService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cервис для сохранения фото
final class ProxyImageService: LoadServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let pathName = "SavedData"
    }

    // MARK: - Private Properties

    private var fileManager = FileManager.default
    private var service: LoadServiceProtocol

    // MARK: - Initializers

    init(service: LoadServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func loadImage(url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let imageName = url.lastPathComponent
        if let casheData = getSavedImage(imageName: imageName) {
            complition(casheData, nil, nil)
        } else {
            service.loadImage(url: url) { [weak self] data, response, error in
                self?.saveImage(imageName: imageName, image: data)
                complition(data, response, error)
            }
        }
    }

    func saveImage(imageName: String, image: Data?) {
        do {
            guard
                let folder = FileManager.default.urls(
                    for: .desktopDirectory,
                    in: .userDomainMask
                ).first?.appending(path: Constants.pathName)
            else {
                return
            }
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let fileURL = folder.appendingPathComponent(imageName)
            try image?.write(to: fileURL)
        } catch {
            print(error)
        }
    }

    func getSavedImage(imageName: String) -> Data? {
        guard
            let url = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first?
            .appending(path: imageName)
        else {
            return nil
        }
        let data = try? Data(contentsOf: url)
        return data
    }
}
