// ProxyService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cервис для сохранения фото
final class Proxy: LoadServiceProtocol {
    var cacheData: Data?

    var fileManager = FileManager()

    //    let fileManager = FileManager()
    //    func saveImage(image: Data) throws {
    //        do {
    //            guard
    //                let folder = FileManager.default.urls(
    //                    for: .documentDirectory,
    //                    in: .userDomainMask
    //                ).first?.appending(path: "SavedData")
    //            else {
    //                return
    //            }
    //            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
    //            let fileURL = folder.appendingPathComponent("savedImageData.json")
    //            try image.write(to: fileURL)
    //        } catch {
    //            print("Unable to save profile data")
    //        }
    //    }
    //
    //    func getSavedImage() -> Data? {
    //        guard
    //            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
    //            .appending(path: "SavedData/savedImageData.json")
    //        else {
    //            return nil
    //        }
    //        let data = try? Data(contentsOf: url)
    //        return data
    //    }

    func saveImage() {}

    func loadImage() {}

    var service: NetworkService

    init(service: NetworkService) {
        self.service = service
    }

    func loadImage(url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if cacheData == nil {
          service.loadImage(url: url) { result in
//            if let image = UIImage(data: result) {
//              let data = image.pngData(self: result)
//            }
            //let data = _.pngData(self: result)
            self.cacheData = result
                complition(result)
            }
        } else {
            complition(cacheData, nil, nil)
        }
    }
}
