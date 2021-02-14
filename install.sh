# bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
VERSION='0.2.0'

NO_COLOR='\033[0m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
echo -e "${CYAN}  ___ _            _    ${YELLOW}  ___                              _    ";
echo -e "${CYAN} / __| |_  ___ _ _| |_  ${YELLOW} / __|___ _ __  _ __  __ _ _ _  __| |___";
echo -e "${CYAN} \__ \ ' \/ _ \ '_|  _| ${YELLOW}| (__/ _ \ '  \| '  \/ _\` | ' \/ _\` (_-<";
echo -e "${CYAN} |___/_||_\___/_|  \__| ${YELLOW} \___\___/_|_|_|_|_|_\__,_|_||_\__,_/__/";
echo -e "${CYAN}                        ${YELLOW}                                        ";
echo -e "${CYAN}                version ${YELLOW}${VERSION}                                   ";
echo -e "${CYAN}                        ${YELLOW}                                        ";

echo -e "${NO_COLOR}Check basic commands of PostgreSQL..."
PSQL="$(which psql)"
if [ ${#PSQL} -eq 0 ]
then
	echo 'First installation psql(PostgreSQL and commands)'
	return
else
	echo "psql is exist. $PSQL"
fi

echo -e "${NO_COLOR}Create DB backup directory..."
mkdir -p dbbackups/local
mkdir -p dbbackups/develop
mkdir -p dbbackups/test
mkdir -p dbbackups/live

echo -e "${NO_COLOR}Install kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo -e "${NO_COLOR}Append script to bashrc..."
printf "
# Short commands for developer
# 
# Included: git aliases
export SHORT_COMMANDS_DIR=\"%s\"
[ -s \"$SHORT_COMMANDS_DIR/index.sh\" ] && \. \"$SHORT_COMMANDS_DIR/index.sh\" 
" $(pwd) >> "$HOME/.bashrc"

source $HOME/.bashrc

echo -e "${YELLOW}Finish! Thank you for using Short commands 😉"
echo -e "${CYAN}Powered by Yungik Joo(jooyungik@gmail.com)"
