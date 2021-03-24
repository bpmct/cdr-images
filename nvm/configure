#!/bin/bash

# if nvm command fails, try to add it to 
if ! command -v nvm &> /dev/null
then
    echo "nvm command not found... attempting to add to your profile via the install script"

    # Create a .profile file if it doesnt exist
    touch ~/.profile

    # run the install script to add to profile
    $NVM_DIR/install.sh

    export NVM_DIR="/usr/bin/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    exit
fi