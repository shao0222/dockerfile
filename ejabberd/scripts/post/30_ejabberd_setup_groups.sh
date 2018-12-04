#!/bin/bash
set -e

source "${EJABBERD_HOME}/scripts/lib/base_config.sh"
source "${EJABBERD_HOME}/scripts/lib/config.sh"
source "${EJABBERD_HOME}/scripts/lib/base_functions.sh"
source "${EJABBERD_HOME}/scripts/lib/functions.sh"


create_group() {
    local group=$1
    local host=$2

    echo "Creating roster group: ${group}@${host}"
    # Do not exit if group already registered
    ${EJABBERDCTL} srg_create ${group} ${host} ${group} '' ${group} || true
}

register_group_member() {
    local user=$1
    local host=$2
    local group=$1
    local grouphost=$2

    echo "Adding ${user} ${host} to roster group ${group}@${grouphost}"
    # Do not exit if user is already a member
    ${EJABBERDCTL} srg_user_add ${user} ${host} ${group} ${grouphost} || true
}


register_all_groups() {
    # register shared roster groups from environment $EJABBERD_GROUPS
    # Use whitespace to seperate groups.
    #
    # sample:
    # - create two groups:
    #   -e "EJABBERD_GROUPS=admin example.com groupname descript display
    #       test@example.com"
    echo "${EJABBERD_GROUPS}"|while read line;do
       eval ${EJABBERDCTL} srg_create $line || true
    done
}

register_all_group_members() {
    # register shared roster group members from environment $EJABBERD_GROUP_MEMBERS
    # Use whitespace to seperate groups.
    #
    # sample:
    # - add two users to groups:
    #   -e "EJABBERD_GROUP_MEMBERS=user xmpp.kx.gd group xmpp.kx.gd 
    #       user2 xmpp.kx.gd group xmpp.kx.gd"
    
    echo "${EJABBERD_GROUP_MEMBERS}" | while read line;do
        eval ${EJABBERDCTL} srg_user_add $line || true
    done
}


file_exist ${FIRST_START_DONE_FILE} \
    && exit 0

is_set ${EJABBERD_GROUPS} \
    && register_all_groups

is_set ${EJABBERD_GROUP_MEMBERS} \
    && register_all_group_members

exit 0
