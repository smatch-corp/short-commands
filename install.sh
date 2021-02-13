# bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

NO_COLOR='\033[0m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
echo -e "${CYAN}  ___ _            _    ${YELLOW}  ___                              _    ";
echo -e "${CYAN} / __| |_  ___ _ _| |_  ${YELLOW} / __|___ _ __  _ __  __ _ _ _  __| |___";
echo -e "${CYAN} \__ \ ' \/ _ \ '_|  _| ${YELLOW}| (__/ _ \ '  \| '  \/ _\` | ' \/ _\` (_-<";
echo -e "${CYAN} |___/_||_\___/_|  \__| ${YELLOW} \___\___/_|_|_|_|_|_\__,_|_||_\__,_/__/";
echo -e "${CYAN}                        ${YELLOW}                                        ";
echo -e "${CYAN}                version ${YELLOW}0.0.0                                   ";
echo -e "${CYAN}                        ${YELLOW}                                        ";
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
