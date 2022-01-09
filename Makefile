.PHONY: help
help: ## Display the descriptions of make tasks
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | sed -e 's/^Makefile://g' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-40s\033[0m %s\n", $$1,$$2}'


.PHONY: all
all: test lint


.PHONY: lint
lint:  .venv ## Run linter
	.venv/bin/pre-commit run --all-files


.PHONY: test
test:  .venv ## Run test
	.venv/bin/tox


.PHONY: pytest
pytest:  ## Run pytest
	PYTHONPATH=src .venv/bin/python -m pytest tests -x --ff


.PHONY: freshup
freshup: distclean  ## Clean up environment
	# (re)create python virtual environment
	python -m venv .venv
	.venv/bin/pip install -U pip setuptools wheel
	.venv/bin/pip install -r requirements/requirements-dev.in


.PHONY: distclean
distclean:  ## Clean up environment
	rm -rf build dist src/*.egg-info .tox .mypy_cache .pytest_cache .coverage .coverage.* htmlcov
	find src tests -name __pycache__ -type d | xargs rm -rf __pycache__
	rm -rf .venv
