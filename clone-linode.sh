#!/bin/bash
# This script makes clones of a linode. Prompts user for the linode number to clone
# then makes and labels clones progressively starting at 1. 

echo "Enter Linode ID:"
read -r id
echo "How many clones to make:"
read -r num

# linode-cli linodes clone $id --label clone-1

# linode-cli linodes boot $(linode-cli linodes list --text | grep clone-1 | grep "\b${1}\b" | awk '{print $1}')

count=1
# if user input is 5 or less, while loop is TRUE
# each iteration makes clone and labels as clone- then the clone number
while ((num<=5)) 
do
if ((num > 0)); then
    linode-cli linodes clone "$id" --label clone-$count
    linode-cli linodes boot "$(linode-cli linodes list --text | grep clone-$count | grep "\b${1}\b" | awk '{print $1}')"
    ((count++))
    ((num--))
else
    exit
fi
done

if ((num > 5)); then
    echo ''
    echo "Linode has a limit of 5 clones of one linode." 
    echo "I may enhance script later, to after 5 clones, make clones of progressive clones."
    echo "But for now, this script will only make 5 or less clones."
    echo "exiting..."
    echo ''
   exit 
fi