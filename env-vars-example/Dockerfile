FROM codercom/enterprise-base:ubuntu

# Here are two ways to get env vars into Coder workspaces.
# If the env vars are private, make sure you 

# Copy a .env file for the project to use
# Make sure you check the "configure" file to move to the proper place
COPY .env /tmp/.env

# Set a workspace-wide env variable 
ENV BEN_TEST=hellohello

COPY configure /coder/configure