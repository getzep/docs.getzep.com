.PHONY: serve

serve:
	. .venv/bin/activate &&	mkdocs serve -a localhost:8001
