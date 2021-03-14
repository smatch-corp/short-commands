# Short commands

## Installation
1. git clone git@github.com:jooyungik/short-commands.git
2. cd short-commands
3. source install.sh
4. (Optional) Edit configs.sh And restart terminal
5. (Optional) If you are MacOS user, add the following code to the `$HOME/.bash_profile`:
  `if [ -f '/Users/terry/.bashrc' ]; then . '/Users/terry/.bashrc'; fi`

## Release Notes
### 0.2.0
- PostgreSQL solutions
  - `dump <DBNAME> [DB Environment: local(default) | develop | live | test ]`
  - `restore <DBNAME> [DB Environment: local(default) | develop | live | test ] [Dumped Environment(Backed up)]`

### 0.1.0
Support k8s aliases

### 0.0.0
Support git aliases

## Features
### 0.3.0
- `help`
- `version`

## 1.0.0
- Remove short-commands
- Install with options 

