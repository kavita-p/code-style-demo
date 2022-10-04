format:
	@isort .
	@black .
lint:
	@flake8 --extend-exclude=.venv --append-config=.flake8
	@echo "✨ Lint-free ✨"