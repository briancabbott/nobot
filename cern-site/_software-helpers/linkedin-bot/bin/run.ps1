# Install dependencies
uv sync



# With full profile enrichment and JSON output
uv run linkedin-bot https://www.linkedin.com/company/cern/ --enrich --output cern_people.json