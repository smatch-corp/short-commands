# Short commands

## Installation

1. `git clone git@github.com:TerryJoo/short-commands.git`
2. `cd short-commands`
3. `source install.sh`
4. Edit `configs.sh` And restart terminal

## PostgreSQL solutions
  - `dump <DB NAME> <SCHEMA NAME> [DB Environment: local(default) | live | test | stage ]`
  - `restore <DB NAME> <SCHEMA NAME> [DB Environment: local(default) | test | stage ] [Dumped Environment(Backed up)]`
  - `drop <DB NAME> <SCHEMA NAME> [DB Environment: local(default) | test | stage ]`

## Smatch plugins
기본적으로 Masking 플러그인 활성화

### Masking

#### Phone Number
`pg_plugins/update_hone_number/index.sql` 조건절에 해당하는 번호를 제외한 모든 사용자/고객 번호를 010XXXXXXXX로 변경

#### Email
`pg_plugins/update_hone_number/index.sql` 조건절에 해당하는 번호를 제외한 모든 사용자/고객 이메일을 *XXXXX로 변경(기본적으로 활성화)
