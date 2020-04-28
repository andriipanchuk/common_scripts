from github import Github
import os
import json
import logging
import sys

logging.basicConfig()
logging.getLogger().setLevel(logging.INFO)

g = Github(os.environ.get("GIT_TOKEN"))

organization_name = "fuchicorp"


organization = g.get_organization(organization_name)
users = [ user.login for user in organization.get_members()]

with open("organization-members.json", 'w') as file:
    json.dump(users, file, indent=2)