#!/bin/sh
# Script to push local git repo changes to a GitHub repo
# Must be called with path to git repo as argument

original_working_directory=$(pwd)

cd ~/nix

git commit -a -m "Local changes autocommit"

git push

cd $original_working_directory
