#!/bin/bash

answers=(yes Yes Y y)
condition=true
declare -a listJokes
stored=1
rm listJokes.txt

while $condition
    do
    echo "Would you like to hear a random joke about Chuck Norris ?"
    read answer

    if [[ "${answers[*]}" =~ "$answer" ]]
        then
            joke=$(curl -s https://api.chucknorris.io/jokes/random | jq -r '."value"')
            echo $joke
    else
            echo "Okay, here let me give you the categories of jokes."
            categories=$(curl -s https://api.chucknorris.io/jokes/categories | jq -r '.[]')
                for category in "${categories[@]}"
                do
                    echo "$category"
                done
            echo ""
            echo "Which category are you interested in ?"
            echo ""
            read chosenCategory
            $joke=$(curl -s https://api.chucknorris.io/jokes/random?category=$chosenCategory | jq -r '."value"' )
            echo ""
            echo "Here is the joke from the $chosenCategory category:"
            echo ""
            echo $joke
    fi

    echo "----------------"
    echo "Would you like to save this joke ?"
    read answer

    if [[ "${answers[*]}" =~ "${answer}" ]]
        then
            stored=0
            listJokes+=("$joke")
    fi

    echo "--------------------"
    echo "Would you like to hear another joke?"
    read answer

    if [[ "${answers[*]}" =~ "${answer}" ]]
        then
            echo "Okay, here we go !"
    else
        condition=false
    fi
done

echo "-------------"

if (( $stored == 0 ))
    then
    printf '%s\n\n' "${listJokes[@]}" >> listJokes.txt
    echo "The jokes have been stored in the file called listJokes.txt"
fi

echo "goodbye!"
echo "---------printing listJokes.txt"
cat listJokes.txt