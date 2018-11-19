docker run -it \
--name liquibase \
--link postgres: \
--entrypoint="/scripts/liquibase_command.sh" \
-v /$LIQUIBASE_CHANGELOGS:/changelogs \
-e CONNECTION_STRING="jdbc:postgresql://$DB_IP:5432/$DB_NAME" \
-e CHANGELOG_FILE=/home/serg/IdeaProjects/shb/builds/db/src/main/changelogs/master.xml \
sequenceiq/docker-liquibase\
"update"