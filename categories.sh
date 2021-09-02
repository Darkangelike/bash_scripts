 #!/bin/bash

curl -s https://api.chucknorris.io/jokes/categories | jq . > categories.json

categories=$( curl -s https://api.chucknorris.io/jokes/categories | jq -r '.[]')

for category in "${categories[@]}"
do
    echo "$category"
done

echo ""
echo "Which category are you interested in ?"
echo ""
read chosenCategory
categoryJoke=$(curl -s https://api.chucknorris.io/jokes/random?category=$chosenCategory | jq -r '."value"' )
echo ""
echo "Here is the joke from the $chosenCategory category:"
echo ""
echo $categoryJoke