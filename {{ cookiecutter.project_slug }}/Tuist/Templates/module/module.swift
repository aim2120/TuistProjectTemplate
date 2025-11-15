import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "A template for creating a new module",
    attributes: [
        nameAttribute,
    ],
    items: [
        .string(path: "modules/\(nameAttribute)/Sources/\(nameAttribute)/\(nameAttribute).swift", contents: "// \(nameAttribute)\n"),
        .file(path: "Modules/\(nameAttribute)/Project.swift", templatePath: "project.stencil"),
        .file(path: "Modules/\(nameAttribute)/Tests/\(nameAttribute)Tests/\(nameAttribute)Tests.swift", templatePath: "tests.stencil"),
    ]
)
