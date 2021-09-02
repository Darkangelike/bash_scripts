#!/bin/bash

# https://api.chucknorris.io/jokes/random

randomJoke=$(curl -s https://api.chucknorris.io/jokes/random | jq -r '."value"')
answers=(Y y Yes yes)

echo $randomJoke
echo "----"
echo "Would you like to save this joke in a file ?"
read answer
if [[ "${answers[*]}" =~ "${answer}" ]]
then
    echo $randomJoke >> listJokes.txt
fi
echo ""
echo "The joke has been saved in the file listJokes.txt"