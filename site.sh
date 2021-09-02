#!/bin/bash

answers=(yes Yes Y y)
condition=true
stored=1
htmlBegin="<html><head><title>Chuck Norris' very bad jokes</title></head><body>"
htmlEnd="</body></html>"
declare -a jokes

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
            jokes+=("<h2>$joke</h2>")
    fi

    echo "Would you like to hear another joke?"
    read answer

    if [[ "${answers[*]}" =~ "${answer}" ]]
        then
            echo "Okay !"
    else
        condition=false
    fi
done

if (( $stored == 0 ))
    then
    website=("$htmlBegin" "${jokes[@]}" "$htmlEnd")
fi

echo "goodbye!"

printf '%s\n' "${website[@]}" > index.html

cp index.html /var/www/html/

firefox localhost