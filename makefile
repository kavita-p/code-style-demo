format:
	@isort .
	@black .
lint:
	@flake8
	@echo "✨ Lint-free ✨"
