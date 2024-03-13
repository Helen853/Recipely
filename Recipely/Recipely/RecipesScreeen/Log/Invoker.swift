// Invoker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Invoker
final class LoggerInvoker {
    // MARK: - Public Properties

    static let shared = LoggerInvoker()

    // MARK: - Private Properties

    private let logger = Logger()
    private var commands: [LogCommand] = []

    // MARK: - Public Methods

    func log(actionUser: LogActions) {
        let command = LogCommand(action: actionUser)
        LoggerInvoker.shared.addLogCommand(command)
    }

    func addLogCommand(_ command: LogCommand) {
        commands.append(command)
        executeCommandsIfNeeded()
    }

    // MARK: - Private Methods

    private func executeCommandsIfNeeded() {
        var stringCommand: [String] = []
        commands.forEach { stringCommand.append($0.log) }
        logger.writeMessageToLog(stringCommand)
    }
}
