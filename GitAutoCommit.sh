#!/bin/bash

# The trap command will be used to execute any final necessary commands when the script
# is exited for any reason.
trap ' if [ "$PUSH_ON_EXIT" = true ]; then
         git push
       fi;' EXIT

# Check that the user has provided any arguments at all. Inform the user how to use the 
# script if they have not provided any arguments.
if [ $# -eq 0 ]; then
  printf "Not enough arguments provided. Please use the format:\n\tGitAutoCommit [Optional Parameters] <Wait_Time>\nUse:\n\tGitAutoCommit --help\nFor further details.\n"
  exit 1
fi 

# Check to see if the user has used --help. If so then print out how to use this script.
if [ "$1" = "--help" ]; then
  printf "Usage:\n\tGitAutoCommit [Optional Parameters] <Wait_Time>\n"
  printf "Where <Wait_Time> is the time in seconds between each autosave and [Optional Parameters] are any of the following:\n\n"
  printf "\t-a Indicate the script to add any new files in the working tree to the index.\n"
  printf "\t-A Indicate the script to not add any new files in the working tree to the index.\n\n"
  printf "\t-b Indicate that the script should checkout a new branch to commit to rather than the current branch.\n"
  printf "\t-B Indicate that the script should commit to the current branch.\n\n"
  printf "\t-p Indicate that the script should push after every commit.\n"
  printf "\t-P Indicate that the script should not push after every commit.\n\n"
  printf "\t-e Indicate that the script should push to the branch when the script exits for any reason.\n"
  printf "\t-E Indicate that the script should not push to the branch when the script exits.\n\n"
  printf "\t-r Indicate that the script should remove any files from the working tree from the repository.\n"
  printf "\t-R indicate that the script should not remove any files.\n\n"
  printf "The default parameters if none are provided are:\n\tGitAutoCommit -b -A -P -e -R <Wait_Time>\n\n"
  exit 1
fi

# If the user has entered the script correctly the last arugment should be the wait time.
# Check that this value is a number and that it is not negative.
if [[ "${@: -1}" =~ ^[+]?[0-9]+$ ]]; then
  WAIT_TIME=${@: -1}
else
  echo "Please provide a whole number greater than 0 for <Wait_Time>"
fi

# Go through the optional arguments and enable or disable the relevant booleans.
BRANCH=true; PUSH=false; ADD_NEW_FILES=true; PUSH_ON_EXIT=true; REMOVE_FILES=false
while getopts 'aAbBpPeErR' opt; do
  case $opt in
    a) ADD_NEW_FILES=true ;;
    A) ADD_NEW_FILES=false ;;
    b) BRANCH=true ;;
    B) BRANCH=false ;;
    p) PUSH=true ;;
    P) PUSH=false ;;
    e) PUSH_ON_EXIT=true ;;
    E) PUSH_ON_EXIT=false ;;
    r) REMOVE_FILES=true ;;
    R) REMOVE_FILES=false ;;
  esac
done

if [ "$BRANCH" = true ]; then
  git checkout -b Auto_Save
fi

# Main body of the script. Loop through git status and add any modified files to the index 
# (Main purpose of this script so this can't be disabled) and if selected Add/Remove any
# relevant files.
while true; do
  # Changed indicates if the working tree has any changes. Otherwise we don't want to
  # commit any changes.
  CHANGED=false
  EXCESS=""; NEW_FILES=""; MODIFIED_FILES=""; REMOVED_FILES=""
  # Save the status to a file for easy access.
  git status -s > Git_Auto_Save_Status
  FILENAME=Git_Auto_Save_Status
  # Loop through the file
  while IFS='' read -r line; do
    # Ignore the file we've just created
    if [ "${line:3:${#line}}" != "Git_Auto_Save_Status" ]; then
      # Add the file if it's been modified.
      if [ "${line:1:1}" = "M" ]; then
        MODIFIED_FILES+="${line:3:${#line}}, "
        git add ${line:3:${#line}} 
        CHANGED=true
      # If enabled remove a file.
      elif [ "${line:1:1}" = "D" ] && [ "$REMOVE_FILES" = true ]; then
        REMOVED_FILES+="${line:3:${#line}}, "
        git rm -f ${line:3:${#line}}  
        CHANGED=true
      # If enabled add any new files.
      elif [ "${line:1:1}" = "?" ] && [ "$ADD_NEW_FILES" = true ]; then
        NEW_FILES+="${line:3:${#line}}, "
        git add ${line:3:${#line}} 
        CHANGED=true
      fi
    fi
  done < $FILENAME
  # Remove the file because it isn't necessary anymore.
  rm -f $FILENAME
  # If there have been any changes then build a comment and commit the changes.
  if [ "$CHANGED" = true ]; then
    COMMENT="Git Auto Save, Date: $(date), New Files: $NEW_FILES Modified Files: $MODIFIED_FILES Removed Files: $REMOVED_FILES"
    git commit -m "$COMMENT"
    # If push every commit is enabled then push the changes through.
    if [ "$PUSH" = true ]; then
      git push 
    fi
  fi
  # Sleep for a specified time before the next update check.
  sleep $WAIT_TIME
done

