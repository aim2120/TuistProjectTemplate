# {{ cookiecutter.project_name }}
{% if cookiecutter.description != "" %}
{{ cookiecutter.description }}
{% endif %}
## Requirements

- [mise](https://mise.jdx.dev)
- [Tuist](https://tuist.io) (managed by mise)
- [Trunk](https://docs.trunk.io/) (managed by mise)
- Xcode ([xcodes](https://github.com/XcodesOrg/xcodes) suggested for tool management)

## Makefile Commands

```bash
make app                       # Generate the app Xcode project
make module name=MyModule      # Generate Xcode project for a module
make new-module name=MyModule  # Scaffold and generate a new module
make clean                     # Clean Tuist artifacts
make very-clean                # Clean Tuist artifacts + git repo
```

## Project Structure

```tree
{{ cookiecutter.project_slug }}/
├── {{ cookiecutter.__app_name }}/
│   ├── Sources/
│   ├── Resources/
│   └── Tests/
├── Modules/
│   └── <module>/
│       ├── Sources/
│       │   └── <target>/
│       └── Tests/
│           └── <test target>/
└── Tuist/
    ├── Templates/
    └── ProjectDescriptionHelpers/
```
