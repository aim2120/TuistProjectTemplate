//
//  Modules.swift
//  Manifests
//
//  Created by Annalise Mariottini on 12/8/24.
//

import Foundation
import OSLog
import ProjectDescription

public func modules() -> [URL] {
    let fm = FileManager.default
    let currentDirectory = fm.currentDirectoryPath
    let modulesURL = URL(filePath: currentDirectory).appending(path: "Modules")
    let contents: [String]

    do {
        contents = try fm.contentsOfDirectory(atPath: modulesURL.absoluteURL.path())
    } catch {
        Logger.logger.error("""
        Failed to get module data
        Error: \(error, privacy: .public)
        """)
        return []
    }

    return contents
        .map {
            modulesURL.appending(path: $0)
        }
        .filter { url in
            let path = url.absoluteURL.path()
            var isDirectory: ObjCBool = false
            return fm.fileExists(atPath: path, isDirectory: &isDirectory) && isDirectory.boolValue
        }
}
