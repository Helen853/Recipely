// Receiver.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Receiver
final class Logger {
    var actions: [String] = []

    func writeMessageToLog(_ message: [String]) {
        let manager = FileManager.default
        guard let url = manager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            return
        }

        let pathUrl = url.appendingPathComponent("log")
        do {
            try manager.createDirectory(at: pathUrl, withIntermediateDirectories: true)
        } catch {
            print("error")
        }

        let logFile = pathUrl.appendingPathComponent("log.txt")
        let data = "\(message)".data(using: .utf8)
        manager.createFile(
            atPath: logFile.path(percentEncoded: true),
            contents: data,
            attributes: [FileAttributeKey.creationDate: Date()]
        )
    }
}
