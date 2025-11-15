//
//  DeploymentTargets+AppDeploymentTargets.swift
//  Manifests
//
//  Created by Annalise Mariottini on 12/14/24.
//

import ProjectDescription

public extension DeploymentTargets {
    {% if cookiecutter.app_destination == "iOS" %}
    static let appDeploymentTargets: Self = .iOS("17.0")
    {% elif cookiecutter.app_destination == "macOS" %}
    static let appDeploymentTargets: Self = .macOS("14.0")
    {% elif cookiecutter.app_destination == "watchOS" %}
    static let appDeploymentTargets: Self = .watchOS("10.0")
    {% elif cookiecutter.app_destination == "tvOS" %}
    static let appDeploymentTargets: Self = .tvOS("17.0")
    {% endif %}
}
