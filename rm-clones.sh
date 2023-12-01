#!/bin/bash
##
## Finds if clone linodes exist in my environment, then iterates through a while loop if TRUE, and parses through all clone-
## names and uses grep and awk to filter and output only the associated linode ID number. Then uses that ID to delete that linode.
## Then repeates for each iteration of while as long as "clone" is TRUE.

# linode-cli linodes delete $(linode-cli linodes list --text | grep clone-1 | grep "\b${1}\b" | awk '{print $1}')

n=1
# as long as linodes are found with "clone" in name, while loop is TRUE
while linode-cli linodes list | grep clone
do
# on first iteration give prompt
# linode-cli linodes delete "$(linode-cli linodes list --text | grep clone-$n | grep "\b${1}\b" | awk '{print $1}')"
if ((n == 1)); then
    echo "**********************************************************************************"
    echo "Found the above clones. Are you sure you want to delete all of these linodes?"
    echo "Enter Y or N:"
    echo "**********************************************************************************"
    read -r stdin
fi
# checks user response, if n or N, exits
if [[ $stdin == [Nn] ]]; then
    echo "Exiting"
    exit
fi
# if user response is not n, N, y, or Y, the prompt for error
if [[ $stdin != [YyNn] ]]; then
    echo "Invalid input, exiting"
    exit
fi

echo "**********************************************************************************"
echo "Deleting Clone-$n"
echo "**********************************************************************************"
# uses grep and awk to filter and output only linode ID number back into the delete command
linode-cli linodes delete "$(linode-cli linodes list --text | grep clone-$n | grep "\b${1}\b" | awk '{print $1}')"
# n = n+1
((n++))
done

echo "No Clones found"