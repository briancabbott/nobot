#  Install dependencies
pip install -r requirements.txt



# With full profile enrichment and JSON output
python bot.py https://www.linkedin.com/company/cern/ --enrich --output cern_people.json