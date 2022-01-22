#!/usr/bin/env python
# https://gist.github.com/opie4624/3896526

import sys, argparse, logging
from requests import get
import xml.etree.ElementTree as ET

def main(args):
    response = get(f"https://cbr.ru/scripts/XML_daily.asp?date_req={args.date}") 
    root = ET.fromstring(response.content)
    hasany = False
    for item in root.findall('./Valute'):
        hasany = True
        valcurrency = next(child for child in item if child.tag == 'CharCode').text
        if valcurrency == args.currency:
            value = next(child for child in item if child.tag == 'Value').text
            print(value)
            exit()
    if not hasany:
        print(f'failed to get valute value')
  

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("currency",
                        help = "currency",
                        metavar = "currency")
    parser.add_argument("date",
                        help = "currency",
                        metavar = "date")
    args = parser.parse_args()

    main(args)
