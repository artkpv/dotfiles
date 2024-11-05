#!python
import sys
import os
from pyzotero import zotero
from pyzotero.zotero_errors import HTTPError

def add_url_to_zotero(api_key, library_id, url):
    zot = zotero.Zotero(library_id, 'user', api_key)

    # Basic item template
    item = zot.item_template('webpage')
    item['title'] = 'Title for the URL'
    item['url'] = url

    # Create the item
    response = zot.create_items([item])
    if 'successful' in response:
        print(f"Successfully added URL to Zotero: {url}")
    else:
        print(f"Failed to add URL to Zotero: {url}")

def main():
    if len(sys.argv) != 2:
        print("Usage: python add_to_zotero.py <URL>")
        sys.exit(1)

    url = sys.argv[1]

    # Fetch API key from environment variable
    api_key = os.environ.get('ZOTERO_API_KEY')
    if api_key is None:
        print("Error: ZOTERO_API_KEY environment variable is not set.")
        sys.exit(1)

    # Replace this with your actual user library ID
    library_id = '_Inbox'

    add_url_to_zotero(api_key, library_id, url)

if __name__ == "__main__":
    main()
