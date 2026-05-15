#!/usr/bin/env python3
"""
LinkedIn company people fetcher.

Uses the unofficial linkedin-api library (github.com/tomquirk/linkedin-api)
which authenticates as a regular LinkedIn member via cookie-based session.

Usage:
    python bot.py <linkedin_company_url> [--output people.json]

Example:
    python bot.py https://www.linkedin.com/company/cern/
    python bot.py https://www.linkedin.com/company/cern/ --output cern_people.json

Setup:
    1. Copy .env.example to .env and fill in your LinkedIn credentials.
    2. uv sync
    3. uv run linkedin-bot <linkedin_company_url>

Note:
    Scraping LinkedIn member data may conflict with LinkedIn's Terms of Service.
    Use this tool responsibly and only for legitimate research purposes.
"""

import argparse
import json
import os
import re
import sys
import time
from typing import Iterator

from dotenv import load_dotenv
from linkedin_api import Linkedin


def parse_company_id(company_url: str) -> str:
    """
    Extract the company slug or numeric ID from a LinkedIn company URL.

    Accepts formats:
        https://www.linkedin.com/company/cern/
        https://www.linkedin.com/company/1234567/
    """
    match = re.search(r'linkedin\.com/company/([^/?#]+)', company_url)
    if not match:
        raise ValueError(
            f"Could not parse a company identifier from URL: {company_url!r}\n"
            "Expected a URL of the form https://www.linkedin.com/company/<id>/"
        )
    return match.group(1).rstrip('/')


def iter_company_employees(
    api: Linkedin,
    company_id: str,
    batch_size: int = 50,
    pause_seconds: float = 1.5,
) -> Iterator[dict]:
    """
    Yield all employee profile dicts for a LinkedIn company, paginating
    through results until the list is exhausted.

    Args:
        api:           Authenticated Linkedin API client.
        company_id:    LinkedIn company slug or numeric ID.
        batch_size:    Number of results to request per page (max ~50).
        pause_seconds: Seconds to wait between paginated requests.
    """
    offset = 0
    while True:
        results = api.search_people(
            current_company=[company_id],
            limit=batch_size,
            offset=offset,
        )
        if not results:
            break
        for person in results:
            yield person
        if len(results) < batch_size:
            # Reached the final (possibly partial) page.
            break
        offset += batch_size
        time.sleep(pause_seconds)


def enrich_person(api: Linkedin, person: dict, pause_seconds: float = 1.0) -> dict:
    """
    Optionally fetch the full profile for a person returned by search.
    Falls back gracefully if the profile is unavailable.

    Args:
        api:           Authenticated Linkedin API client.
        person:        Slim search-result dict (contains 'urn_id' / 'public_id').
        pause_seconds: Courtesy delay after fetching.
    """
    public_id = person.get("public_id")
    if not public_id:
        return person
    try:
        profile = api.get_profile(public_id)
        time.sleep(pause_seconds)
        return profile
    except Exception:
        return person


def build_person_record(person: dict) -> dict:
    """
    Extract a clean, minimal record from a LinkedIn profile dict.
    Handles both the slim search result and the full profile format.
    """
    first = person.get("firstName", "") or person.get("first_name", "")
    last = person.get("lastName", "") or person.get("last_name", "")
    headline = person.get("headline", "")
    location = person.get("locationName", "") or person.get("location", "")
    public_id = person.get("public_id", "") or person.get("publicIdentifier", "")
    urn_id = person.get("urn_id", "")

    # Extract current position summary when available (full profile only)
    positions = []
    experience = person.get("experience", [])
    for exp in experience:
        company_name = (exp.get("companyName") or "")
        title = (exp.get("title") or "")
        if company_name or title:
            positions.append({"title": title, "company": company_name})

    return {
        "name": f"{first} {last}".strip(),
        "headline": headline,
        "location": location,
        "public_id": public_id,
        "urn_id": urn_id,
        "profile_url": (
            f"https://www.linkedin.com/in/{public_id}/" if public_id else ""
        ),
        "positions": positions,
    }


def print_person(record: dict) -> None:
    """Print a single person record to stdout in a readable format."""
    print(f"Name      : {record['name']}")
    print(f"Headline  : {record['headline']}")
    print(f"Location  : {record['location']}")
    print(f"Profile   : {record['profile_url']}")
    if record["positions"]:
        print("Positions :")
        for pos in record["positions"]:
            print(f"  - {pos['title']} @ {pos['company']}")
    print("-" * 60)


def main() -> None:
    load_dotenv()

    parser = argparse.ArgumentParser(
        description="Fetch all people associated with a LinkedIn company.",
    )
    parser.add_argument(
        "company_url",
        help="Full LinkedIn company URL, e.g. https://www.linkedin.com/company/cern/",
    )
    parser.add_argument(
        "--output",
        metavar="FILE",
        default=None,
        help="Write results as JSON to this file (default: print to stdout only).",
    )
    parser.add_argument(
        "--enrich",
        action="store_true",
        default=False,
        help=(
            "Fetch full profile details for each person "
            "(slower; one extra request per person)."
        ),
    )
    parser.add_argument(
        "--pause",
        type=float,
        default=1.5,
        metavar="SECONDS",
        help="Seconds to pause between paginated requests (default: 1.5).",
    )
    args = parser.parse_args()

    email = os.getenv("LINKEDIN_EMAIL")
    password = os.getenv("LINKEDIN_PASSWORD")
    if not email or not password:
        print(
            "Error: LINKEDIN_EMAIL and LINKEDIN_PASSWORD must be set.\n"
            "Copy .env.example to .env and fill in your credentials.",
            file=sys.stderr,
        )
        sys.exit(1)

    try:
        company_id = parse_company_id(args.company_url)
    except ValueError as exc:
        print(f"Error: {exc}", file=sys.stderr)
        sys.exit(1)

    print(f"Authenticating as {email} …", file=sys.stderr)
    try:
        api = Linkedin(email, password)
    except Exception as exc:
        print(f"Authentication failed: {exc}", file=sys.stderr)
        sys.exit(1)

    print(f"Fetching employees for company: {company_id!r} …\n", file=sys.stderr)

    records = []
    for person in iter_company_employees(api, company_id, pause_seconds=args.pause):
        if args.enrich:
            person = enrich_person(api, person, pause_seconds=args.pause)
        record = build_person_record(person)
        records.append(record)
        print_person(record)

    print(f"\nTotal people found: {len(records)}", file=sys.stderr)

    if args.output:
        with open(args.output, "w", encoding="utf-8") as f:
            json.dump(records, f, ensure_ascii=False, indent=2)
        print(f"Results saved to: {args.output}", file=sys.stderr)


if __name__ == "__main__":
    main()
