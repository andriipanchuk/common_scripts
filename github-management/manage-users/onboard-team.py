import requests
import os
import argparse
from github import Github

## Organization name and token on env
organization = 'fuchicorp'
token = os.environ.get("GIT_ADMIN_TOKEN")


## Getting github user 
g = Github(token, base_url='https://api.github.com')

## Getting organization 
org = g.get_organization(organization)


with open('github-management/manage-users/users-to-add.txt') as file:
    users = file.read().splitlines()

## Getting all members of organization 
def get_users(users):
    
    ## Empty list which will be returned 
    result = []
    for user in users:
        try:
            ## Trying to get user and append to result
            result.append(g.get_user(user))
        except:
            print(f"User not found <{user}>")
    return result

user_clases = get_users(users)

## Looping to each team in organization 
for team in org.get_teams():

    ## If team name is members 
    if 'devops' == team.name.lower():

        ## Looping to all memebers 
        for user in user_clases:

            ## Adding people to members team
            team.add_to_members(user)
            print(f"User <{user.login}> added to devops")
        