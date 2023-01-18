RED='\033[0;31m'
NO_COLOR='\033[0m'
EXTENSION=tar
# Deprecated in smatch office. See INFRA_COMMANDS_DIR
# alias db="psql" 
alias dbdev="PGPASSWORD=$DEVELOP_DBPASS psql -h $DEVELOP_DBHOST -U $DEVELOP_DBUSERNAME"
alias dbtest="PGPASSWORD=$TEST_DBPASS psql -h $TEST_DBHOST -U $TEST_DBUSERNAME"
alias dbstage="PGPASSWORD=$STAGE_DBPASS psql -h $STAGE_DBHOST -U $STAGE_DBUSERNAME"
alias dblive="PGPASSWORD=$LIVE_DBPASS psql -h $LIVE_DBHOST -U $LIVE_DBUSERNAME"

dump() {
	[ -z $3 ] && TARGET=local || TARGET=$3
	[ -z $2 ] && SCHEMA=public || SCHEMA=$2
	mkdir -p $DB_BACKUP_DIR/$TARGET/$1
	case $TARGET in
		develop)
			PGPASSWORD=$DEVELOP_DBPASS pg_dump -h $DEVELOP_DBHOST -U $DEVELOP_DBUSERNAME -n $SCHEMA -c $1 -F t >| $DB_BACKUP_DIR/$TARGET/$1/$SCHEMA.$EXTENSION
		;;
		test)
			PGPASSWORD=$TEST_DBPASS pg_dump -h $TEST_DBHOST -U $TEST_DBUSERNAME -n $SCHEMA -c $1 -F t >| $DB_BACKUP_DIR/$TARGET/$1/$SCHEMA.$EXTENSION
		;;
		stage)
			PGPASSWORD=$STAGE_DBPASS pg_dump -h $STAGE_DBHOST -U $STAGE_DBUSERNAME -n $SCHEMA -c $1 -F t >| $DB_BACKUP_DIR/$TARGET/$1/$SCHEMA.$EXTENSION
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

	drop $1 $2 $3
	case $TARGET in
		develop)
			PGPASSWORD=$DEVELOP_DBPASS pg_restore -h $DEVELOP_DBHOST -U $DEVELOP_DBUSERNAME -d $1 $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION

			# Run plugins
			dbdev -d $1 -f $SHORT_COMMANDS_DIR/pg_plugins/update_for_stage/index.sql
		;;
		test)
			# dbtest $1 < $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION
			PGPASSWORD=$TEST_DBPASS pg_restore -h $TEST_DBHOST -U $TEST_DBUSERNAME -d $1 $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION

			# Run plugins
			dbtest -d $1 -f $SHORT_COMMANDS_DIR/pg_plugins/update_for_stage/index.sql
		;;
		stage)
			# dbstage $1 < $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION
			PGPASSWORD=$STAGE_DBPASS pg_restore -h $STAGE_DBHOST -U $STAGE_DBUSERNAME -d $1 $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION

			# Run plugins
			dbstage -d $1 -f $SHORT_COMMANDS_DIR/pg_plugins/update_for_stage/index.sql
		;;
		live)
			echo -e "${RED}위험!${NO_COLOR} 이 시도는 실수일 가능성이 높습니다. 원하는 경우 수동으로 진행하십시오."
			# psql -h $LIVE_DBHOST -U $LIVE_DBHOST $1 < $DB_BACKUP_DIR/$SOURCE/$1/SCHEMA.$EXTENSION
		;;
		local)
			pg_restore -d $1 $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION

			# Run plugins
			# psql -d $1 -f $SHORT_COMMANDS_DIR/pg_plugins/update_for_stage/index.sql
		;;
	esac
}

drop() {
	[ -z $2 ] && SCHEMA=public || SCHEMA=$2
	[ -z $3 ] && TARGET=local || TARGET=$3
	echo "$SCHEMA 의 모든 테이블 드랍(DB명: $1)"
	case $TARGET in
		develop)
			dbdev $1 -v schemaname=$SCHEMA < $SHORT_COMMANDS_DIR/pg_plugins/drop_all_tables/make_drop_query.sql | grep drop | dbdev $1;
		;;
		test)
			# dbtest $1 < $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION
			dbtest $1 -v schemaname=$SCHEMA < $SHORT_COMMANDS_DIR/pg_plugins/drop_all_tables/make_drop_query.sql | grep drop | dbtest $1;
		;;
		stage)
			# dbstage $1 < $DB_BACKUP_DIR/$SOURCE/$1/$SCHEMA.$EXTENSION
			dbstage $1 -v schemaname=$SCHEMA < $SHORT_COMMANDS_DIR/pg_plugins/drop_all_tables/make_drop_query.sql | grep drop | dbstage $1;
		;;
		live)
			echo -e "${RED}위험!${NO_COLOR} 이 시도는 실수일 가능성이 높습니다. 원하는 경우 수동으로 진행하십시오."
		;;
		local)
			psql $1 -v schemaname=$SCHEMA < $SHORT_COMMANDS_DIR/pg_plugins/drop_all_tables/make_drop_query.sql | grep drop | psql $1;
		;;
	esac
}

# dump > drop > restore
ddr_stage_live() {
	dump $1 $2 live
	# 전처리
	restore $1 $2 develop
	dump $1 $2 develop
	# 전처리 완료, stage 데이터 restore
	restore $1 $2 stage develop
}