
setup:
	poetry install

lint:
	poetry run ruff check .

format:
	poetry run ruff check --fix .

test:
	poetry run pytest tests

.PHONY: setup lint format test
