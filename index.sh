GIT='_git.sh'
KUBECTL='_kubectl.sh'
CONFIGS='configs.sh'
PG='_pg.sh'

# Imports
# 줄여져 있는 깃 커맨드도 사용하고 싶다면, 바로 아래 주석 한 줄을 살리고, 터미널을 재실행하십시오.
# [ -s "$SHORT_COMMANDS_DIR/$GIT" ] && \. "$SHORT_COMMANDS_DIR/$GIT"
# 만약 kubernates를 사용하게 된다면...
# [ -s "$SHORT_COMMANDS_DIR/$KUBECTL" ] && \. "$SHORT_COMMANDS_DIR/$KUBECTL"
[ -s "$SHORT_COMMANDS_DIR/$CONFIGS" ] && \. "$SHORT_COMMANDS_DIR/$CONFIGS"
[ -s "$SHORT_COMMANDS_DIR/$PG" ] && \. "$SHORT_COMMANDS_DIR/$PG"
