#!/bin/bash

# Check if the necessary tools are installed
default_dependencies=("gh" "jq" "confused")
for cmd in "${default_dependencies[@]}"; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed. Please install it before running this script."
        exit 1
    fi
done

# Ask for the GitHub username or organization
read -p "Enter the GitHub username or organization name: " github_user

# Create a folder to store dependency files
output_folder="dependency_files"
mkdir -p "$output_folder"

# Fetch the list of repositories using GitHub CLI
echo "Fetching repositories for $github_user..."
repos=$(gh repo list "$github_user" --limit 200 --json nameWithOwner -q '.[].nameWithOwner')

if [ -z "$repos" ]; then
    echo "No repositories found for $github_user or authentication is required."
    exit 1
fi

# Supported dependency files
dependency_files=("package.json" "requirements.txt" "pom.xml" "Gemfile")

# Fetch dependency files directly using GitHub API
for repo in $repos; do
    repo=$(echo $repo | tr -d '"') # Remove quotes from JSON strings
    for file in "${dependency_files[@]}"; do
        echo "Checking for $file in $repo..."
        file_url="https://api.github.com/repos/$repo/contents/$file"
        file_download_url=$(curl -s -H "Accept: application/vnd.github.v3+json" "$file_url" | jq -r .download_url)

        if [ "$file_download_url" != "null" ]; then
            echo "Downloading $file from $repo..."
            curl -s "$file_download_url" -o "$output_folder/$(echo $repo | tr '/' '_')_$file"
        else
            echo "$file not found in $repo."
        fi
    done
done

# Check if any dependency files were found
if [ -z "$(ls -A $output_folder)" ]; then
    echo "No dependency files found in any repositories."
    exit 1
fi

# Run Confused on the collected dependency files
echo "Running Confused to check for dependency confusion vulnerabilities..."
confused "$output_folder"/*

# Completion message
echo "Analysis complete. Please review the output above for potential issues."
