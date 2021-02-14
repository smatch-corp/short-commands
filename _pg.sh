RED='\033[0;31m'
NO_COLOR='\033[0m'

dump() {
	[ -z $2 ] && TARGET=local || TARGET=$2
	case $TARGET in
		develop)
			pg_dump -h $DEVELOP_DBHOST -U $DEVELOP_DBUSERNAME -c $1 >| $DB_BACKUP_DIR/$TARGET/$1.sql
		;;
		test)
			pg_dump -h $TEST_DBHOST -U $TEST_DBUSERNAME -c $1 >| $DB_BACKUP_DIR/$TARGET/$1.sql
		;;
		live)
			pg_dump -h $LIVE_DBHOST -U $LIVE_DBUSERNAME -c $1 >| $DB_BACKUP_DIR/$TARGET/$1.sql
		;;
		local)
			pg_dump -c $1 >| $DB_BACKUP_DIR/$TARGET/$1.sql
		;;
	esac
}
restore() {
	[ -z $2 ] && TARGET=local || TARGET=$2
	[ -z $3 ] && SOURCE=$TARGET || SOURCE=$3
	echo Taget is..
	echo $TARGET
	echo Source is..
	echo $SOURCE
	case $TARGET in
		develop)
			psql -h $DEVELOP_DBHOST -U $DEVELOP_DBUSERNAME $1 < $DB_BACKUP_DIR/$SOURCE/$1.sql
		;;
		test)
			psql -h $TEST_DBHOST -U $TEST_DBHOST $1 < $DB_BACKUP_DIR/$SOURCE/$1.sql
		;;
		live)
			echo "${RED}Error!${NO_COLOR} Live restore is not supported."
			return
			# psql -h $LIVE_DBHOST -U $LIVE_DBHOST $1 < $DB_BACKUP_DIR/$SOURCE/$1.sql
		;;
		local)
			psql $1 < $DB_BACKUP_DIR/$SOURCE/$1.sql
		;;
	esac
}

