# Cookiecutter Tuist Project

A Cookiecutter template for modular Apple platform projects using Tuist.

## Requirements

- [cookiecutter](https://cookiecutter.readthedocs.io)
- [mise](https://mise.jdx.dev)

## Usage

Generate a new project:

```bash
cookiecutter gh:aim2120/cookiecutter-tuist-project
```

The post-generation hook will:

- Initialize git repository
- Install Tuist and Trunk via mise
- Set up Trunk for linting/formatting
- Optionally generate the Xcode project

## Project Structure

- Modular architecture with independent Swift modules
- Pre-configured example modules: `LoggingService`, `RESTService`
- Tool versions managed via `mise.toml`

## Adding Modules

Use Tuist scaffolding:

```bash
tuist scaffold module --name YourModule
```
