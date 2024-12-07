# Dependency Confusion Vulnerability Scanner

This project provides a Bash script to scan GitHub repositories for potential dependency confusion vulnerabilities. The script retrieves common dependency files (e.g., `package.json`, `requirements.txt`, `pom.xml`, `Gemfile`) and analyzes them using the [Confused](https://github.com/visma-prodsec/confused) tool.

## Features

- Fetches only dependency files directly from repositories without cloning the entire repo.
- Supports multiple dependency types:
  - JavaScript (`package.json`)
  - Python (`requirements.txt`)
  - Java (`pom.xml`)
  - Ruby (`Gemfile`)
- Utilizes GitHub CLI (`gh`) and GitHub API for efficient file retrieval.
- Detects potential dependency confusion vulnerabilities using the `Confused` tool.

### Tools

Ensure the following tools are installed on your system:

- [GitHub CLI (gh)](https://cli.github.com/)
- [jq](https://stedolan.github.io/jq/)
- [Confused](https://github.com/visma-prodsec/confused)

## Installation

Use the provided `install.sh` script to install the required dependencies:

```bash
chmod +x install.sh
./install.sh
```

## Usage

1. Clone this repository or download the script files.

2. Add executable permissions to the file `chmod +x *`

3. Run the `install.sh` script for installing the dependency files.

```bash
./install.sh
```


4. Run the `dependency_confusion.sh` script:

```bash
./dependency_confusion.sh
```

5. Enter the GitHub username or organization name when prompted.

6. The script will:
   - Fetch dependency files from the repositories.
   - Analyze them using the `Confused` tool.
   - Display results of the analysis.

### Example Output

```plaintext
Fetching repositories for example-user...
Checking for package.json in example-user/repo1...
Downloading package.json from example-user/repo1...
Checking for requirements.txt in example-user/repo1...
requirements.txt not found in example-user/repo1.
...
Running Confused to check for dependency confusion vulnerabilities...
Analysis complete. Please review the output above for potential issues.
```

## File Structure

- `dependency_confusion.sh`: Main script to fetch dependency files and analyze them.
- `install.sh`: Installs the required tools and dependencies.
- `dependency_files/`: Directory where fetched dependency files are stored.

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue to suggest improvements or additional features.


## References

- [Confused - Dependency Confusion Tool](https://github.com/visma-prodsec/confused)
- [GitHub CLI Documentation](https://cli.github.com/manual/)

