#!/bin/sh

read -p "This will delete all your local branches and you will basically lose all local work almost forever. Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Fetching upstream..."
    git fetch upstream
    echo "Deleting all local branches..."
    git for-each-ref --format '%(refname:short)' refs/heads | grep -v master | xargs git branch -D
    Echo "Updating master and dev specifically"
    git checkout master
    git reset --hard upstream/master  
    git push origin master --force

    git checkout dev
    git reset --hard upstream/dev  
    git push origin dev --force

    echo "Any branch you have pushed to origin will now need push --force."
fi
 
echo "done."

