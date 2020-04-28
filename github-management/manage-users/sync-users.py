import requests
import os
import argparse
from github import Github

## organization name and token on env
organization = 'fuchicorp'

token = os.environ.get("GIT_ADMIN_TOKEN")

g = Github('fsadykov', token, base_url='https://api.github.com')
org = g.get_organization('fuchicorp')

users = [ user for user in org.get_members()]

for team in org.get_teams():
    if 'members' == team.name.lower():
        for user in users:
            team.add_to_members(user)
            print(f"User <{user}> added to members")
        