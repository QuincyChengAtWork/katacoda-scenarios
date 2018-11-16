Run docker-compose exec client bash to get a bash shell with the Conjur client software
Initialize the Conjur client using the account name and admin API key you created:

`conjur init -u conjur -a quick-start`{{execute}} # or whatever account you created
`conjur authn login -u admin`{{execute}}
Please enter admin\'s password (it will not be echoed):
