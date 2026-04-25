import requests

import logging

logger = logging.Logger(__name__)

# get config

import json
with open("config.json") as fp:
    CONFIG = json.load(fp)

# https://www.reddit.com/r/Discord_Bots/comments/ugp938/api_is_it_possible_to_fetch_the_member_count_with/
API_ENDPOINT_BASE = "https://discord.com/api/v9/invites/"

API_ENDPOINT = API_ENDPOINT_BASE + CONFIG["invite"]

# https://stackoverflow.com/a/28147286
import datetime
now = datetime.datetime.now().isoformat()

print("Currently", now)

response = requests.get(API_ENDPOINT)

if response.status_code == 200:
    data = response.json()
    count = data["profile"]["member_count"]
    date = datetime.date.today()
    time = datetime.datetime.now().time()
    with open("member_count.out", "a") as fp:
        # date, time, member count
        fp.write(f"{date}\t{time}\t{count}\n")
    print("Written:", date, time, count)
else:
    print("Non-200 status code returned. Please check it.")
    print("HTTP", response.status_code)
    print(response.text)