import requests
import os
import argparse
from github import Github

## organization name and token on env
organization = 'fuchicorp'

header = {"Authorization": f'token {token}', "Accept" : "application/vnd.github.inertia-preview+json"}


token = os.environ.get("GIT_ADMIN_TOKEN")

with open('github-management/manage-users/users-to-add.txt') as file:
    users = file.read().splitlines()

g = Github('fsadykov', token, base_url='https://api.github.com')
org = g.get_organization('fuchicorp')


teams = org.get_teams()

def get_users(users):
    result = []
    for user in users:
        try:
            result.append(g.get_user(user))
        except:
            print(f"User not found <{user}>")
    return result

user_clases = get_users(users)

for team in teams:
    if team.name.lower() == "members":
        for user in user_clases:
            org.invite_user(user=user, teams=[team])
