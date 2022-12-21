RED='\033[0;31m'
NO_COLOR='\033[0m'
EXTENSION=tar
# Deprecated in smatch office. See INFRA_COMMANDS_DIR
# alias db="psql" 
# alias dbdev="PGPASSWORD=$DEVELOP_DBPASS psql -h $DEVELOP_DBHOST -U $DEVELOP_DBUSERNAME"
alias dbtest="PGPASSWORD=$TEST_DBPASS psql -h $TEST_DBHOST -U $TEST_DBUSERNAME"
alias dblive="PGPASSWORD=$LIVE_DBPASS psql -h $LIVE_DBHOST -U $LIVE_DBUSERNAME"

dump() {
	[ -z $3 ] && TARGET=local || TARGET=$3
	[ -z $2 ] && SCHEMA=public || SCHEMA=$2
	mkdir -p $DB_BACKUP_DIR/$TARGET/$1
	case $TARGET in
		# develop)
		# 	PGPASSWORD=$DEVELOP_DBPASS pg_dump -h $DEVELOP_DBHOST -U $DEVELOP_DBUSERNAME -n $SCHEMA -c $1 -F t >| $DB_BACKUP_DIR/$TARGET/$1/$SCHEMA.$EXTENSION
		# ;;
		test)
			PGPASSWORD=$TEST_DBPASS pg_dump -h $TEST_DBHOST -U $TEST_DBUSERNAME -n $SCHEMA -c $1 -F t >| $DB_BACKUP_DIR/$TARGET/$1/$SCHEMA.$EXTENSION
		;;
		live)
			PGPASSWORD=$LIVE_DBPASS pg_dump -h $LIVE_DBHOST -U $LIVE_DBUSERNAME -n $SCHEMA -c $1 -F t >| $DB_BACKUP_DIR/$TARGET/$1/$SCHEMA.$EXTENSION
		;;
		local)
			pg_dump -n $SCHEMA -c $1 -F t >| $DB_BACKUP_DIR/$TARGET/$1/$SCHEMA.$EXTENSION
		;;
	esac
}
restore() {
	[ -z $2 ] && SCHEMA=public || SCHEMA=$2
	[ -z $3 ] && TARGET=local || TARGET=$3
	[ -z $4 ] && SOURCE=$TARGET || SOURCE=$4
	echo Taget is..
	echo $TARGET
	echo Source is..
	echo $SOURCE
	case $TARGET in
		# develop)
		# 	dbdev $1 < $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION
		# ;;
		test)
			# dbtest $1 < $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION
			PGPASSWORD=$TEST_DBPASS pg_restore -h $TEST_DBHOST -U $TEST_DBUSERNAME -d $1 $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION
		;;
		live)
			echo -e "${RED}Error!${NO_COLOR} Live restore is not supported."
			return
			# psql -h $LIVE_DBHOST -U $LIVE_DBHOST $1 < $DB_BACKUP_DIR/$SOURCE/$1/SCHEMA.$EXTENSION
		;;
		local)
			pg_restore -d $1 $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION
		;;
	esac
}

