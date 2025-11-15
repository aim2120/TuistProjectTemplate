//
//  BundleID.swift
//  Manifests
//
//  Created by Annalise Mariottini on 12/8/24.
//

public var bundleID: String {
    "com.{{ cookiecutter.username }}.{{ cookiecutter.__app_name }}"
}

public func bundleID(name: String) -> String {
    "\(bundleID).\(name)"
}