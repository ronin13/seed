#!/usr/bin/python
import twitter
import sys

term=str(sys.argv[1])

if len(sys.argv) > 2:
    passw = str(sys.argv[2])
else:
    passw = None
api= twitter.Api(username='emptyvacuum', password=passw)
user="emptyvacuum"
import re
import sys
import time

statuses= api.GetUserTimeline(user)

list=[s.text for s in statuses]

#print list
linkpos=None
matches=[]

if term == "all":
    print list
    exit()


for text in list:
    if re.match("^.*"+term+".*$",text):
            matches.append(text)

print matches

