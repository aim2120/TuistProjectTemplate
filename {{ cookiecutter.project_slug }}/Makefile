.PHONY: scaffold module app clean very-clean

new-module: install
ifndef name
	$(error name is required. Usage: make scaffold-module name=MyModule)
endif
	tuist scaffold module --name $(name)
	tuist generate --path Modules/$(name)

module: install
ifndef name
	$(error name is required. Usage: make generate-module name=MyModule)
endif
	tuist generate --path Modules/$(name)

app: install
	tuist generate

install:
	tuist install

clean:
	tuist clean

very-clean: clean
	git clean -xdff --exclude=Tuist/.build