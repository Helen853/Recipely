// Invoker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Invoker
final class LoggerInvoker {
    static let shared = LoggerInvoker()
    private let logger = Logger()
    private var commands: [LogCommand] = []

    func log(actionUser: LogActions) {
        let command = LogCommand(action: actionUser)
        LoggerInvoker.shared.addLogCommand(command)
    }

    func addLogCommand(_ command: LogCommand) {
        commands.append(command)
        executeCommandsIfNeeded()
    }

    private func executeCommandsIfNeeded() {
        var stringCommand: [String] = []
        commands.forEach { stringCommand.append($0.log) }
        logger.writeMessageToLog(stringCommand)
    }
}
