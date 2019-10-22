export KEYCLOAK_VERSION=7.0.1

export JBOSS_HOME=keycloak-$KEYCLOAK_VERSION

export USER=
export PASS=

if [ -d "$JBOSS_HOME" ]; then
  	rm -rf $JBOSS_HOME
   	sleep 1s
fi


export KEYCLOAK_DIST=keycloak-$KEYCLOAK_VERSION.tar.gz
if [ ! -e "$KEYCLOAK_DIST" ]; then
   	echo " KEYCLOAK_DIST: $KEYCLOAK_DIST not yet downloaded. Dowloading dist"
   	curl -O https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz
else
	echo " KEYCLOAK_DIST: $KEYCLOAK_DIST"
fi

# Unpack naked keycloak
tar xzf $KEYCLOAK_DIST

# Install oracle jdbc driver
mkdir -p $JBOSS_HOME/modules/system/layers/base/com/oracle/ojdbc6/main
cp ojdbc6-11.2.0.3.jar $JBOSS_HOME/modules/system/layers/base/com/oracle/ojdbc6/main/
cp module.xml $JBOSS_HOME/modules/system/layers/base/com/oracle/ojdbc6/main/

$JBOSS_HOME/bin/jboss-cli.sh --file=standalone-configuration.cli

# SQL> select name from v$pdbs;
# SQL> alter session set container = xepdb1;
# SQL> show con_name;

# CREATE USER keycloak IDENTIFIED BY password;
# GRANT CONNECT TO keycloak;
# GRANT RESOURCE, DBA TO keycloak;
# GRANT UNLIMITED TABLESPACE TO keycloak;
