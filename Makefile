# This is a placeholder Makefile.
# @tutorial-init will replace this with stack-specific dev commands.

.PHONY: docs docs-build

# Start docs dev server
docs:
	cd docs-site && npm run docs:dev

# Build docs for production
docs-build:
	cd docs-site && npm run docs:build
